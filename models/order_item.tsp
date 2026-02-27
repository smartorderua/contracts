import "@typespec/openapi";

using OpenAPI;

model OrderItemBase {
    @extension(ExtraTags, #{ db: "menu_item_id" })
    menuItemId: UUID;
}

model OrderItemInput {
    ...OrderItemBase;
    toppings: string[];
}

model OrderItem {
    ...OrderItemBase;
    id: UUIDPrimaryKey;

    @extension(ExtraTags, #{ db: "total_price" })
    totalPrice: int32;
}

model OrderItemWithDetails {
    ...OrderItem;
    menuItem: MenuItem;
}
