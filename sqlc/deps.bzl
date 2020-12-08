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

load("//sqlc/private:release.bzl", _sqlc_register_toolchains = "sqlc_register_toolchains")
load("//sqlc/private:repo.bzl", _sqlc_rules_dependencies = "sqlc_rules_dependencies")

sqlc_register_toolchains = _sqlc_register_toolchains
sqlc_rules_dependencies = _sqlc_rules_dependencies
