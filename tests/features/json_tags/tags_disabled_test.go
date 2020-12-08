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
	"reflect"
	"testing"

	"github.com/plezentek/bazel-sqlc/tests/features/json_tags/disabled_database"
)

func TestShouldNotHaveJsonTags(t *testing.T) {
	model := disabled_database.Release{ID: 1, Version: "1.0.0"}
	kind := reflect.TypeOf(model)
	tagsFound := false
	for index := 0; index < kind.NumField(); index++ {
		field := kind.Field(index)
		tag := field.Tag.Get("json")
		if tag != "" {
			tagsFound = true
		}
	}
	if tagsFound {
		t.Errorf("JSON tags found on generated model")
	}
}
