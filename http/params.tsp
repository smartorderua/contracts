import "@typespec/http";

using Http;

model TenantParams {
    @path tenantId: string;
}

model OrderParams {
    ...TenantParams;
    @path orderId: string;
}
