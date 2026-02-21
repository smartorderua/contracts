import "@typespec/openapi";

alias ExtraTags = "x-oapi-codegen-extra-tags";

using OpenAPI;

@format("bsonid")
scalar BsonId extends string;

@extension(ExtraTags, #{ bson: "_id,omitempty" })
scalar BsonEntityId extends BsonId;
