-- Copyright 2020 Plezentek, Inc. All rights reserved
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--    http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

CREATE TABLE releases (
    id BIGSERIAL PRIMARY KEY,
    type01 SERIAL,
    type02 SMALLSERIAL,
    type03 INTEGER,
    type04 BIGINT,
    type05 SMALLINT,
    type06 FLOAT,
    type07 REAL,
    type08 NUMERIC,
    type09 BOOLEAN,
    type10 JSON,
    type11 BLOB,
    type12 DATE,
    type13 PG_CATALOG.TIME,
    type14 TIMESTAMPTZ,
    type15 TEXT,
    type16 UUID,
    type17 INET,
    type18 MACADDR,
    type19 LTREE,
    type20 INTERVAL,
    type21 VOID,
    type22 BIGSERIAL NOT NULL,
    type23 SERIAL NOT NULL,
    type24 SMALLSERIAL NOT NULL,
    type25 INTEGER NOT NULL,
    type26 BIGINT NOT NULL,
    type27 SMALLINT NOT NULL,
    type28 FLOAT NOT NULL,
    type29 REAL NOT NULL,
    type30 NUMERIC NOT NULL,
    type31 BOOLEAN NOT NULL,
    type32 JSON NOT NULL,
    type33 BLOB NOT NULL,
    type34 DATE NOT NULL,
    type35 PG_CATALOG.TIME NOT NULL,
    type36 TIMESTAMPTZ NOT NULL,
    type37 TEXT NOT NULL,
    type38 UUID NOT NULL,
    type39 INET NOT NULL,
    type40 MACADDR NOT NULL,
    type41 LTREE NOT NULL,
    type42 INTERVAL NOT NULL
);
