import "@typespec/openapi";

using OpenAPI;

model OrderItemBase {
    @extension(ExtraTags, #{ bson: "menu_item_id,omitempty" })
    menuItemId: BsonId;
}

model OrderItemInput {
    ...OrderItemBase;
    toppings: string[];
}

model OrderItem {
    ...OrderItemBase;
    id: BsonEntityId;

    @extension(ExtraTags, #{ bson: "total_price,omitempty" })
    totalPrice: int32;
}

model OrderItemWithDetails {
    ...OrderItem;
    menuItem: MenuItem;
}
