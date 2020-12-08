#!/bin/bash

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

set -euo pipefail

function test_package_name {
  package_name="$1"
  shift

  for GENFILE in "$@"; do
    if ! grep -e "^package $package_name" "$GENFILE"; then
      cat >&2 <<EOF
SQLC Generated file $GENFILE missing package name $package_name
EOF
      exit 1
    fi
done
}

test_package_name $1
