import "@typespec/openapi";

using OpenAPI;

model EntityBase {
    id: BsonEntityId;

    @extension(ExtraTags, #{ bson: "created_at,omitempty" })
    createdAt: utcDateTime;

    @extension(ExtraTags, #{ bson: "updated_at,omitempty" })
    updatedAt: utcDateTime;
}
