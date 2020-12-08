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
	"database/sql"
	"encoding/json"
	"math"
	"net"
	"testing"
	"time"

	"github.com/google/uuid"
	"github.com/plezentek/bazel-sqlc/tests/features/overrides/disabled_database"
)

type NativeRelease struct {
	ID     int64
	Type01 sql.NullInt32
	Type02 int16
	Type03 sql.NullInt32
	Type04 sql.NullInt64
	Type05 int16
	Type06 sql.NullFloat64
	Type07 sql.NullFloat64
	Type08 sql.NullString
	Type09 sql.NullBool
	Type10 json.RawMessage
	Type11 []byte
	Type12 sql.NullTime
	Type13 sql.NullTime
	Type14 sql.NullTime
	Type15 sql.NullString
	Type16 uuid.UUID
	Type17 net.IP
	Type18 net.HardwareAddr
	Type19 sql.NullString
	Type20 sql.NullInt64
	Type21 sql.NullBool
	Type22 int64
	Type23 int32
	Type24 int16
	Type25 int32
	Type26 int64
	Type27 int16
	Type28 float64
	Type29 float32
	Type30 string
	Type31 bool
	Type32 json.RawMessage
	Type33 []byte
	Type34 time.Time
	Type35 time.Time
	Type36 time.Time
	Type37 string
	Type38 uuid.UUID
	Type39 net.IP
	Type40 net.HardwareAddr
	Type41 string
	Type42 int64
}

func TestModelShouldHaveNativeTypes(t *testing.T) {
	native := NativeRelease{
		ID:     math.MaxInt64,
		Type01: sql.NullInt32{Int32: math.MaxInt32, Valid: true},
		Type02: math.MaxInt16,
		Type03: sql.NullInt32{Int32: math.MaxInt32, Valid: true},
		Type04: sql.NullInt64{Int64: math.MaxInt64, Valid: true},
		Type05: math.MaxInt16,
		Type06: sql.NullFloat64{Float64: math.MaxFloat64, Valid: true},
		Type07: sql.NullFloat64{Float64: math.MaxFloat64, Valid: true},
		Type08: sql.NullString{String: "string", Valid: true},
		Type09: sql.NullBool{Bool: true, Valid: true},
		Type10: []byte("{}"),
		Type11: []byte("<blob>"),
		Type12: sql.NullTime{Time: time.Now(), Valid: true},
		Type13: sql.NullTime{Time: time.Now(), Valid: true},
		Type14: sql.NullTime{Time: time.Now(), Valid: true},
		Type15: sql.NullString{String: "string", Valid: true},
		Type16: uuid.New(),
		Type17: net.IP{192, 168, 0, 1},
		Type18: net.HardwareAddr{0x00, 0x00, 0x5E, 0x00, 0x53, 0x00},
		Type19: sql.NullString{String: "string", Valid: true},
		Type20: sql.NullInt64{Int64: math.MaxInt64, Valid: true},
		Type21: sql.NullBool{Bool: true, Valid: true},
		Type22: math.MaxInt64,
		Type23: math.MaxInt32,
		Type24: math.MaxInt16,
		Type25: math.MaxInt32,
		Type26: math.MaxInt64,
		Type27: math.MaxInt16,
		Type28: math.MaxFloat64,
		Type29: math.MaxFloat32,
		Type30: "string",
		Type31: true,
		Type32: []byte("{}"),
		Type33: []byte("<blob>"),
		Type34: time.Now(),
		Type35: time.Now(),
		Type36: time.Now(),
		Type37: "string",
		Type38: uuid.New(),
		Type39: net.IP{192, 168, 0, 1},
		Type40: net.HardwareAddr{0x00, 0x00, 0x5E, 0x00, 0x53, 0x00},
		Type41: "string",
		Type42: math.MaxInt64,
	}
	release := disabled_database.Release{
		ID:     native.ID,
		Type01: native.Type01,
		Type02: native.Type02,
		Type03: native.Type03,
		Type04: native.Type04,
		Type05: native.Type05,
		Type06: native.Type06,
		Type07: native.Type07,
		Type08: native.Type08,
		Type09: native.Type09,
		Type10: native.Type11,
		Type11: native.Type11,
		Type12: native.Type12,
		Type13: native.Type13,
		Type14: native.Type14,
		Type15: native.Type15,
		Type16: native.Type16,
		Type17: native.Type17,
		Type18: native.Type18,
		Type19: native.Type19,
		Type20: native.Type20,
		Type21: native.Type21,
		Type22: native.Type22,
		Type23: native.Type23,
		Type24: native.Type24,
		Type25: native.Type25,
		Type26: native.Type26,
		Type27: native.Type27,
		Type28: native.Type28,
		Type29: native.Type29,
		Type30: native.Type30,
		Type31: native.Type31,
		Type32: native.Type32,
		Type33: native.Type33,
		Type34: native.Type34,
		Type35: native.Type35,
		Type36: native.Type36,
		Type37: native.Type37,
		Type38: native.Type38,
		Type39: native.Type39,
		Type40: native.Type40,
		Type41: native.Type41,
		Type42: native.Type42,
	}
	t.Logf("Correctly compiled model without overrides: %v", release)
}
