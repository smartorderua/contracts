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

    @extension(ExtraTags, #{ db: "client_name" })
    clientName: string;

    @extension(ExtraTags, #{ db: "client_phone" })
    clientPhone: string;

    @extension(ExtraTags, #{ db: "payment_method" })
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

    @extension(ExtraTags, #{ db: "tenant_id" })
    tenantId: TenantUniqueId;

    @extension(ExtraTags, #{ db: "readable_id" })
    @doc("A random six-digit code for the order")
    readableId: string;

    @extension(ExtraTags, #{ db: "invoice_id" })
    @doc("Only present if PaymentMethod is set to Online")
    invoiceId?: string;
}

model OrderWithDetails {
    ...OrderBase;

    @extension(ExtraTags, #{ db: "tenant_id" })
    tenantId: TenantUniqueId;

    @extension(ExtraTags, #{ db: "readable_id" })
    @doc("A random six-digit code for the order")
    readableId: string;

    @extension(ExtraTags, #{ db: "invoice_id" })
    @doc("Only present if PaymentMethod is set to Online")
    invoiceId?: string;

    status: OrderStatus;
    items: OrderItemWithDetails[];
}
