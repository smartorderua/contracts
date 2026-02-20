import "@typespec/openapi";

using OpenAPI;

@extension("x-oapi-codegen-extra-tags", #{ bson: "_id,omitempty" })
scalar BsonId extends string;
