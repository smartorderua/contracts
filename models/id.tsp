import "@typespec/openapi";

alias ExtraTags = "x-oapi-codegen-extra-tags";

using OpenAPI;

@extension("x-go-type", "uuid.UUID")
@extension(
    "x-go-type-import",
    #{ path: "github.com/google/uuid", name: "uuid" }
)
@format("uuid")
scalar UUID extends string;

@extension(ExtraTags, #{ db: "id,omitempty" })
scalar UUIDPrimaryKey extends UUID;
