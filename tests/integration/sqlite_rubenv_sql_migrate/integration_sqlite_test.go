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
	"context"
	"database/sql"
	"io/ioutil"
	"testing"

	_ "github.com/mattn/go-sqlite3"
	"github.com/plezentek/bazel-sqlc/tests/integration/sqlite_rubenv_sql_migrate/database"
	"github.com/rubenv/sql-migrate"
)

func createTable(t *testing.T, db *sql.DB) {
	create_statement, err := ioutil.ReadFile("schema.sql")
	if err != nil {
		t.Errorf("Error reading schema file: %v", err)
	}

	migrations := &migrate.MemoryMigrationSource{
		Migrations: []*migrate.Migration{
			&migrate.Migration{
				Id:   "123",
				Up:   []string{string(create_statement)},
				Down: []string{"DROP TABLE releases"},
			},
		},
	}
	_, err = migrate.Exec(db, "sqlite3", migrations, migrate.Up)
	if err != nil {
		t.Errorf("Error creating table: %v", err)
	}

}

func TestCanCreateDatabase(t *testing.T) {
	db, err := sql.Open("sqlite3", ":memory:")
	defer db.Close()

	if err != nil {
		t.Errorf("Error opening database: %v", err)
	}

	createTable(t, db)
}

func TestCanInsertRelease(t *testing.T) {
	db, err := sql.Open("sqlite3", ":memory:")
	defer db.Close()

	if err != nil {
		t.Errorf("Error opening database: %v", err)
	}

	createTable(t, db)

	ctx, _ := context.WithCancel(context.Background())

	q := database.New(db)
	err = q.CreateRelease(ctx, "Test")
	if err != nil {
		t.Errorf("Error creating release: %v", err)
		return
	}
}

func TestListReleases(t *testing.T) {
	db, err := sql.Open("sqlite3", ":memory:")
	defer db.Close()

	if err != nil {
		t.Errorf("Error opening database: %v", err)
	}

	createTable(t, db)

	ctx, _ := context.WithCancel(context.Background())

	q := database.New(db)
	err = q.CreateRelease(ctx, "Test")
	if err != nil {
		t.Errorf("Error creating release: %v", err)
		return
	}

	rows, err := q.ListReleases(ctx)
	if err != nil {
		t.Errorf("Error listing entries: %v", err)
		return
	}
	t.Logf("Found rows: %v", rows)
}
