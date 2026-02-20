import "@typespec/openapi";

using OpenAPI;

enum OrderStatus {
    Paid: "paid",
    Pending: "pending",
    Cancelled: "cancelled",
}

model OrderItemInput {
    tableId: int32;
    menuItemId: string;
    toppings: string[];
}

model OrderItem {
    id: BsonId;
    totalPrice: int32;

    @extension("x-faker", #{ `random.alpha`: #[16] })
    tenantId: string;

    @extension("x-faker", #{ `random.alpha`: #[16] })
    menuItemId: string;

    @extension("x-faker", #{ `random.alpha`: #[16] })
    invoiceId?: string;
}
