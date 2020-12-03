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

-- name: GetRelease :one
SELECT * FROM releases
WHERE id = $1 LIMIT 1;

-- name: ListReleases :many
SELECT * FROM releases
ORDER BY id;

-- name: CreateRelease :exec
INSERT INTO releases (
  version
) VALUES (
  $1
);

-- name: DeleteRelease :exec
DELETE FROM releases
WHERE id = $1;

-- name: UpdateReleaseCreationTime :exec
UPDATE releases SET creation_time = NOW()
WHERE id = $1;
