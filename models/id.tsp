import "@typespec/openapi";

alias ExtraTags = "x-oapi-codegen-extra-tags";

using OpenAPI;

@extension("x-go-type", "bson.ObjectID")
@extension(
    "x-go-type-import",
    #{ path: "go.mongodb.org/mongo-driver/v2/bson", name: "bson" }
)
scalar BsonId extends string;

@extension(ExtraTags, #{ bson: "_id,omitempty" })
scalar BsonEntityId extends BsonId;
