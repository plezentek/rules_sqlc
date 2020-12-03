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

"""Public definitions for SQLC rules.

All public SQLC rules, providers, and other definitions are imported and
re-exported in this file. This allows the real location of definitions to
change for easier maintenance.

Definitions outside this file are private unless otherwise noted, and may
change without notice.
"""

load("//sqlc/private/rules:release.bzl", _sqlc_release = "sqlc_release")
load("//sqlc/private/rules:package.bzl", _sqlc_package = "sqlc_package")
load(
    "//sqlc/private:sqlc_toolchain.bzl",
    _declare_toolchains = "declare_toolchains",
    _sqlc_toolchain = "sqlc_toolchain",
)
load(
    "//sqlc/private:providers.bzl",
    _SQLCRelease = "SQLCRelease",
)

SQLCRelease = _SQLCRelease

declare_toolchains = _declare_toolchains
sqlc_release = _sqlc_release
sqlc_package = _sqlc_package
sqlc_toolchain = _sqlc_toolchain
