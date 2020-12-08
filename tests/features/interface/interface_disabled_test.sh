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

function test_file_list_contains_query_file {
  interface_found=0
  for GENFILE in "$@"; do
    if [[ "$GENFILE" == */querier.go ]]; then
      interface_found=1
    fi
  done

  if [ "$interface_found" -eq 1 ]; then
    cat >&2 <<EOF
Found interface file querier.go in list of generated files
EOF
    exit 1
  fi
}

test_file_list_contains_query_file "$@"
