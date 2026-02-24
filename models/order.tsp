import "@typespec/openapi";

using OpenAPI;

enum OrderStatus {
    Pending: "pending",
    InProgress: "in_progress",
    Completed: "completed",
    Cancelled: "cancelled",
}

enum OrderPaymentMethod {
    Cash: "cash",
    Online: "online",
    CreditCard: "credit_card",
}

model OrderBase {
    comment: string;

    @extension(ExtraTags, #{ bson: "client_name" })
    clientName: string;

    @extension(ExtraTags, #{ bson: "client_phone" })
    clientPhone: string;

    @extension(ExtraTags, #{ bson: "payment_method,omitempty" })
    paymentMethod: OrderPaymentMethod;
}

model OrderInput {
    ...OrderBase;
    items: OrderItemInput[];
}

model Order {
    ...EntityBase;
    ...OrderBase;
    items: OrderItem[];
    status: OrderStatus;

    @extension(ExtraTags, #{ bson: "tenant_id,omitempty" })
    tenantId: BsonId;

    @extension(ExtraTags, #{ bson: "readable_id" })
    readableId: string;

    // only present when PaymentMethod is Online
    @extension(ExtraTags, #{ bson: "invoice_id,omitempty" })
    invoiceId?: string;
}

model OrderWithDetails extends Order {
    items: OrderItemWithDetails[];
}
