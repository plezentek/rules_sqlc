// Copyright 2020 Plezentek, Inc. All rights reserved
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package main

import (
	"testing"
	"unsafe"

	"github.com/plezentek/bazel-sqlc/tests/features/prepared_queries/disabled_database"
)

type NoPreparedQueries struct {
	db disabled_database.DBTX
}

func TestStructShouldNotContainPreparedQueries(t *testing.T) {
	// These must be structs and not pointers to structs in order for this test
	// to be correct
	noPrepared := NoPreparedQueries{}
	underTest := disabled_database.Queries{}

	const noPreparedSize = unsafe.Sizeof(noPrepared)
	const underTestSize = unsafe.Sizeof(underTest)

	if noPreparedSize != underTestSize {
		t.Errorf("Queries struct should not contain prepared queries")
	}
}
