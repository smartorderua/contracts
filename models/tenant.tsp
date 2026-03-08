import "@typespec/openapi";

using OpenAPI;

model TenantInput {
    @minLength(1)
    name: string;

    @minLength(4)
    @extension(ExtraTags, #{ db: "unique_id,omitempty" })
    uniqueId: string;
}

model Tenant {
    ...EntityBase;
    ...TenantInput;
}

model TenantWithRoles {
    ...Tenant;
    admins: UUID[];
    staff: UUID[];
}
