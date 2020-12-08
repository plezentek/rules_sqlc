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

load("//sqlc/private:actions.bzl", "sqlc_compile", "sqlc_configure")

def _sqlc_package_impl(ctx):
    # For output files, we use a unique per-target prefix to avoid conflict
    # with files from other targets in the same package (which would otherwise
    # be placed into the same package directory)
    target_prefix = ctx.label.name + "%/"

    # Despite the docs claiming that you can pass in only a single file or
    # multiple paths, the code shows that you can send multiple files, which is
    # necessary to support mixing query and schema files in the same package
    queries = [q.path for q in ctx.files.queries]

    # Do the same for schema
    schemas = [s.path for s in ctx.files.schema]

    # Generate a sqlc.json file to be used by the sqlc binary.  We track the
    # depth to this file from the execroot so that we can perform path smashing
    # later.
    json_config = ctx.actions.declare_file(target_prefix + "sqlc.json")

    # TODO(Windows) Figure out path handling for windows
    config_path_depth = len(json_config.dirname.split("/"))

    # This JSON config controls SQLC execution
    sqlc_configure(
        ctx,
        params = ctx.attr,
        queries = queries,
        schemas = schemas,
        out = json_config,
        config_path_depth = config_path_depth,
    )

    # SQLC outputs one schema(db) file, one models file, one additional file if
    # the interface is requested, and one file for each query file.
    schema_file = ctx.actions.declare_file(target_prefix + "db.go")
    models_file = ctx.actions.declare_file(target_prefix + "models.go")
    outputs = [schema_file, models_file]

    if ctx.attr.emit_interface:
        interface_file = ctx.actions.declare_file(target_prefix + "querier.go")
        outputs.append(interface_file)

    for query_file in ctx.files.queries:
        outputs.append(ctx.actions.declare_file(target_prefix + query_file.basename + ".go"))

    compile_sources = [json_config] + ctx.files.queries + ctx.files.schema
    sqlc_compile(
        ctx,
        config_file = json_config,
        config_path_depth = config_path_depth,
        srcs = compile_sources,
        out = outputs,
    )

    # TODO(V2) Investigate direct compilation by embedding a go_library rule
    return struct(providers = [
        DefaultInfo(
            files = depset(outputs),
            runfiles = ctx.runfiles(outputs),  # For tests
        ),
    ])

sqlc_package = rule(
    _sqlc_package_impl,
    attrs = {
        "package": attr.string(
            doc = "Use this for the package name rather than the rule name.",
        ),
        "queries": attr.label_list(
            allow_files = [".sql"],
            doc = "Source SQL query files to compile for this library",
        ),
        "schema": attr.label_list(
            allow_files = [".sql"],
            doc = "Source SQL migration files to compile for this library",
        ),
        "engine": attr.string(
            default = "postgresql",
            doc = "Either postgresql or mysql. MySQL support is experimental",
            values = ["postgresql", "mysql", "mysql:beta", "_lemon", "_dolphin", "_elephant"],
        ),
        "overrides": attr.string_dict(
            doc = "A dictionary of type overrides mapping from type to package (e.g. \"uuid\":\"github.com/gofrs/uuid.UUID\" or \"uuid:nullable\":\"github.com/gofrs/uuid.UUID\" if nullable)",
        ),
        "emit_json_tags": attr.bool(
            default = False,
            doc = "If true, add JSON tags to generated structs",
        ),
        "emit_prepared_queries": attr.bool(
            default = False,
            doc = "If true, include support for prepared queries",
        ),
        "emit_interface": attr.bool(
            default = False,
            doc = "If true, output a Querier interface in the generated package",
        ),
        "emit_exact_table_names": attr.bool(
            default = False,
            doc = "If true, struct names will mirror table names. Otherwise, sqlc attempts to singularize plural table names",
        ),
        "emit_empty_slices": attr.bool(
            default = False,
            doc = "If true, slices returned by :many queries will be empty instead of nil",
        ),
    },
    doc = """
sqlc generates **fully type-safe idiomatic Go code** from SQL.

Example:
```
    sqlc_package(
        name = "database",
        queries = "query.sql",
        schema = "schema.sql",
    )
```
""",
    executable = False,
    output_to_genfiles = True,
    toolchains = ["@com_plezentek_rules_sqlc//sqlc:toolchain"],
)
