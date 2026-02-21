import "@typespec/openapi";

using OpenAPI;

enum OrderStatus {
    Paid: "paid",
    Pending: "pending",
    Cancelled: "cancelled",
}

model OrderItemBase {
    @extension(ExtraTags, #{ bson: "table_id,omitempty" })
    tableId: int32;

    @extension(ExtraTags, #{ bson: "menu_item_id,omitempty" })
    menuItemId: string;
}

model OrderItemInput {
    ...OrderItemBase;
    toppings: string[];
}

model OrderItem {
    ...OrderItemBase;
    ...EntityBase;

    @extension(ExtraTags, #{ bson: "tenant_id,omitempty" })
    tenantId: BsonId;

    @extension(ExtraTags, #{ bson: "total_price,omitempty" })
    totalPrice: int32;

    @extension(ExtraTags, #{ bson: "invoice_id" })
    invoiceId?: string;
}
