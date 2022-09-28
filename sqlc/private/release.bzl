# Copyright 2020 Plezentek, Inc. All rights reserved
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

load(
    "//sqlc/private/rules_go/lib:platforms.bzl",
    "generate_toolchain_names",
)
load(
    "@com_plezentek_rules_sqlc//sqlc/private/skylib/lib:versions.bzl",
    "versions",
)
load(
    "//sqlc/private:sqlc_versions.bzl",
    "DEFAULT_VERSION",
    "MIN_SUPPORTED_VERSION",
    "SQLC_VERSIONS",
)

##### Download SQLC binary #####
def _detect_host_platform(ctx):
    if ctx.os.name == "linux":
        goos = ctx.os.name
    elif ctx.os.name == "mac os x":
        goos = "darwin"
    elif ctx.os.name.startswith("windows"):
        goos = "windows"
    elif ctx.os.name == "freebsd":
        goos = "freebsd"
    else:
        fail("missing mapping between os name {} and goos".format(ctx.os.name))

    if goos in ("linux", "darwin", "freebsd"):
        arch_result = ctx.execute(("uname", "-m"))
        if arch_result.return_code != 0:
            fail("unable to detect host architecture:\n" + arch_result.stdout + arch_result.stderr)
        uname = arch_result.stdout.strip()
        if uname in ("aarch64", "arm64"):
            goarch = "arm64"
        elif uname in ("armv6l", "armv7l"):
            goarch = "arm"
        elif uname in ("amd64", "x86_64"):
            goarch = "amd64"
        elif uname in ("i686", "i386"):
            goarch = "386"
        elif uname == "ppc64le":
            goarch = "ppc64le"
        else:
            fail("missing mapping between machine architecture {} and goarch".format(uname))
    elif goos == "windows":
        fail("windows is not currently supported, patches are welcome")
    else:
        fail("unknown os type {}, so unable to detect architecture".format(goos))

    return goos, goarch

def _get_constraints(goos, goarch):
    os_constraint = goos
    if os_constraint == "darwin":
        os_constraint = "macos"

    arch_constraint = goarch
    if arch_constraint == "amd64":
        arch_constraint = "x86_64"
    elif arch_constraint == "386":
        arch_constraint = "x86_32"
    elif arch_constraint == "ppc64le":
        arch_constraint = "ppc"

    return (os_constraint, arch_constraint)

def _sqlc_download_release_impl(ctx):
    if not ctx.attr.version:
        version = DEFAULT_VERSION
    elif ctx.attr.version not in SQLC_VERSIONS:
        fail("unknown SQLC version: " + ctx.attr.version)
    else:
        version = ctx.attr.version
    if not versions.is_at_least(MIN_SUPPORTED_VERSION, version):
        fail("sqlc_download_release: minimum supported version of sqlc is " + MIN_SUPPORTED_VERSION)
    sqlc_platforms = SQLC_VERSIONS[version]

    if not ctx.attr.goos and not ctx.attr.goarch:
        # Default to building same target and architecture as host
        goos, goarch = _detect_host_platform(ctx)
    else:
        if not ctx.attr.goos:
            fail("goos set but goarch not set")
        if not ctx.attr.goarch:
            fail("goarch set but goos not set")
        goos = ctx.attr.goos
        goarch = ctx.attr.goarch
    platform = goos + "_" + goarch
    constraints = _get_constraints(goos, goarch)
    constraint_str = ",\n        ".join(['"%s"' % (c,) for c in constraints])

    if platform not in sqlc_platforms:
        fail("unsupported platform " + platform)

    filename, sha256 = sqlc_platforms[platform]

    ctx.file("ROOT")
    ctx.template(
        "BUILD.bazel",
        Label("@com_plezentek_rules_sqlc//sqlc/private:BUILD.sqlc.bazel"),
        executable = False,
        substitutions = {
            "{goos}": goos,
            "{goarch}": goarch,
            "{version}": version,
            "{exec_constraints}": constraint_str,
            "{target_constraints}": constraint_str,
            "{exe}": ".exe" if goos == "windows" else "",
        },
    )

    # Get the binary tool
    ctx.report_progress("downloading")
    ctx.download_and_extract(
        url = [url.format(version, filename) for url in ctx.attr.urls],
        sha256 = sha256,
    )

_sqlc_download_release = repository_rule(
    _sqlc_download_release_impl,
    attrs = {
        "goos": attr.string(),
        "goarch": attr.string(),
        "urls": attr.string_list(default = ["https://github.com/kyleconroy/sqlc/releases/download/v{}/{}"]),
        "version": attr.string(),
    },
)

def sqlc_download_release(name, **kwargs):
    _sqlc_download_release(name = name, **kwargs)
    _register_toolchains(name)

##### Register Toolchain #####
def _register_toolchains(repo):
    labels = [
        "@{}//:{}".format(repo, name)
        for name in generate_toolchain_names()
    ]

    native.register_toolchains(*labels)

def sqlc_register_toolchains(version = None):
    # Call download
    sqlc_download_release(
        name = "sqlc_release",
        version = version,
    )
