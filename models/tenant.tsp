import "@typespec/openapi";

using OpenAPI;

model TenantInput {
    name: string;

    @extension(ExtraTags, #{ bson: "unique_id,omitempty" })
    uniqueId: string;
}

model Tenant {
    ...EntityBase;
    ...TenantInput;
    admins: BsonId[];
    staff: BsonId[];
}
