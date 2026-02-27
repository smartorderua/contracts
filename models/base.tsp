import "@typespec/openapi";

using OpenAPI;

model EntityBase {
    id: UUIDPrimaryKey;

    @extension(ExtraTags, #{ db: "created_at" })
    createdAt: utcDateTime;

    @extension(ExtraTags, #{ db: "updated_at" })
    updatedAt: utcDateTime;
}
