import "@typespec/openapi";

using OpenAPI;

model TenantInput {
    @minLength(4)
    @maxLength(30)
    name: string;

    @extension(ExtraTags, #{ db: "unique_id,omitempty" })
    uniqueId: TenantUniqueId;
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
