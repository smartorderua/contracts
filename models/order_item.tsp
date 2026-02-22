import "@typespec/openapi";

using OpenAPI;

model OrderItemBase {
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

    @extension(ExtraTags, #{ bson: "total_price,omitempty" })
    totalPrice: int32;
}
