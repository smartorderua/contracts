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
    @extension("x-faker", #{ `random.alpha`: #[16] })
    id: string;

    @extension(
        "x-faker",
        #{ `random.number`: #{ min: 100000, max: 450000, presicion: 10 } }
    )
    totalPrice: int32;

    @extension("x-faker", #{ `random.alpha`: #[16] })
    tenantId: string;

    @extension("x-faker", #{ `random.alpha`: #[16] })
    menuItemId: string;

    @extension("x-faker", #{ `random.alpha`: #[16] })
    invoiceId?: string;
}
