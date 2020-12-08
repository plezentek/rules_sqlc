<!-- Generated with Stardoc: http://skydoc.bazel.build -->

<a name="#sqlc_package"></a>

## sqlc_package

<pre>
sqlc_package(<a href="#sqlc_package-name">name</a>, <a href="#sqlc_package-emit_empty_slices">emit_empty_slices</a>, <a href="#sqlc_package-emit_exact_table_names">emit_exact_table_names</a>, <a href="#sqlc_package-emit_interface">emit_interface</a>, <a href="#sqlc_package-emit_json_tags">emit_json_tags</a>,
             <a href="#sqlc_package-emit_prepared_queries">emit_prepared_queries</a>, <a href="#sqlc_package-engine">engine</a>, <a href="#sqlc_package-overrides">overrides</a>, <a href="#sqlc_package-package">package</a>, <a href="#sqlc_package-queries">queries</a>, <a href="#sqlc_package-schema">schema</a>)
</pre>


sqlc generates **fully type-safe idiomatic Go code** from SQL.

Example:
```
    sqlc_package(
        name = "database",
        queries = "query.sql",
        schema = "schema.sql",
    )
```


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :-------------: | :-------------: | :-------------: | :-------------: | :-------------: |
| name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| emit_empty_slices |  If true, slices returned by :many queries will be empty instead of nil   | Boolean | optional | False |
| emit_exact_table_names |  If true, struct names will mirror table names. Otherwise, sqlc attempts to singularize plural table names   | Boolean | optional | False |
| emit_interface |  If true, output a Querier interface in the generated package   | Boolean | optional | False |
| emit_json_tags |  If true, add JSON tags to generated structs   | Boolean | optional | False |
| emit_prepared_queries |  If true, include support for prepared queries   | Boolean | optional | False |
| engine |  Either postgresql or mysql. MySQL support is experimental   | String | optional | "postgresql" |
| overrides |  A dictionary of type overrides mapping from type to package (e.g. "uuid":"github.com/gofrs/uuid.UUID" or "uuid:nullable":"github.com/gofrs/uuid.UUID" if nullable)   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> String</a> | optional | {} |
| package |  Use this for the package name rather than the rule name.   | String | optional | "" |
| queries |  Source SQL query files to compile for this library   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| schema |  Source SQL migration files to compile for this library   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |


