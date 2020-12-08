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

function test_return_value_is_empty_slice {
  query_file_found=0
  for GENFILE in "$@"; do
    if [[ "$GENFILE" == */query.sql.go ]]; then
      query_file_found=1
      if ! grep -e '^[[:space:]]\+items := \[]Release{}' "$GENFILE"; then
      cat >&2 <<EOF
SQLC Generated file $GENFILE does not return empty slice for empty query
EOF
        exit 1
      fi
    fi
  done

  if [ "$query_file_found" -eq 0 ]; then
    cat >&2 <<EOF
Did not find query file query.sql.go in list of generated files
EOF
    exit 1
  fi
}

test_return_value_is_empty_slice "$@"
