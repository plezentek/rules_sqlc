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

	"github.com/gofrs/uuid"
	"github.com/plezentek/bazel-sqlc/tests/features/overrides/column_enabled_database"
)

type Overrides struct {
	Type16 uuid.UUID
	Type38 uuid.UUID
}

func TestModelShouldHaveTypesOverriden(t *testing.T) {
	override := Overrides{
		Type16: uuid.Must(uuid.NewV4()),
		Type38: uuid.Must(uuid.NewV4()),
	}
	release := column_enabled_database.Release{
		Type16: override.Type16,
		Type38: override.Type38,
	}
	t.Logf("Correctly compiled model with column type overrides: %v", release)
}
