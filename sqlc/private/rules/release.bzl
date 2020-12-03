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

load("//sqlc/private:providers.bzl", "SQLCRelease")

def _sqlc_release_impl(ctx):
    return [SQLCRelease(
        version = ctx.attr.version,
        goos = ctx.attr.goos,
        goarch = ctx.attr.goarch,
        root_file = ctx.file.root_file,
        sqlc = ctx.executable.sqlc,
    )]

sqlc_release = rule(
    _sqlc_release_impl,
    attrs = {
        "goos": attr.string(
            mandatory = True,
            doc = "The host OS the release was built for",
        ),
        "goarch": attr.string(
            mandatory = True,
            doc = "The host architecture the release was built for",
        ),
        "root_file": attr.label(
            mandatory = True,
            allow_single_file = True,
            doc = "The root file in the directory.",
        ),
        "sqlc": attr.label(
            mandatory = True,
            allow_single_file = True,
            executable = True,
            cfg = "exec",
            doc = "The sqlc binary",
        ),
        "version": attr.string(
            mandatory = True,
            doc = "The version of this release",
        ),
    },
    doc = "Information about a SQLC binary release",
    provides = [SQLCRelease],
)
