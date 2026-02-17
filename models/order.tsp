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
    id: string;
    totalPrice: int32;
    tenantId: string;
    menuItemId: string;
    invoiceId?: string;
}
