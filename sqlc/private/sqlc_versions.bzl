# Copyright 2020 Plezentek, Inc. All rights reserved
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

DEFAULT_VERSION = "1.6.0"

MIN_SUPPORTED_VERSION = "1.3.0"

SQLC_VERSIONS = {
    "1.6.0": {
        "darwin_amd64": ("sqlc-v1.6.0-darwin-amd64.tar.gz", "386b6fea4e402c316c4218176abdd3d4e833f209999ef9154d78b3e3b2ec563c"),
        "linux_amd64": ("sqlc-v1.6.0-linux-amd64.tar.gz", "a246200942c926dc76c8803d7fd5a2a5f4e9fbcde44a95408be6ce7d377523c5"),
    },
    "1.5.0": {
        "darwin_amd64": ("sqlc-v1.5.0-darwin-amd64.tar.gz", "139bd15e38f46c782004cee08790603f01921e8a913ffafbea6379d70cff6175"),
        "linux_amd64": ("sqlc-v1.5.0-linux-amd64.tar.gz", "ce9cb631489b81fa979bec0de93506eb894c65e03694173478a158c4d7115a7e"),
    },
    "1.4.0": {
        "darwin_amd64": ("sqlc-v1.4.0-darwin-amd64.tar.gz", "fec091f44ba4a6a3c1d64f05cc70b71f6694847b24085fa6bb1dc5a65904f6d8"),
        "linux_amd64": ("sqlc-v1.4.0-linux-amd64.tar.gz", "c6d651f5dd254f3e4a21925b5350e1be75cd7afac356bfe1249b77c0ba750a95"),
    },
    "1.3.0": {
        "darwin_amd64": ("sqlc-v1.3.0-darwin-amd64.tar.gz", "7db833ab1626c42c57131616a3d4e5a1115d25c491255a0f73e3f9ea8cd06849"),
        "linux_amd64": ("sqlc-v1.3.0-linux-amd64.tar.gz", "9faf3be4d6846cdaf5653bbdbc596390390cc7ff58b66726b267077d2d033a3c"),
    },
}
