import "@typespec/http";
import "../models";

using Http;

model TenantParams {
    @path tenantId: TenantUniqueId;
}

model OrderParams {
    ...TenantParams;
    @path orderId: string;
}
