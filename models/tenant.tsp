import "@typespec/openapi";

using OpenAPI;

model TenantInput {
    name: string;

    @extension(ExtraTags, #{ db: "unique_id,omitempty" })
    uniqueId: string;
}

model Tenant {
    ...EntityBase;
    ...TenantInput;
    admins: UUID[];
    staff: UUID[];
}
