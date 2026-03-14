import "@typespec/openapi";

using OpenAPI;

model OrderItemBase {
    @extension(ExtraTags, #{ db: "menu_item_id" })
    menuItemId: UUID;
}

/**
 * The input model for creating or updating an order item.
 */
model OrderItemInput {
    ...OrderItemBase;

    @doc("An array of selected toppings' ids")
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
    toppings: Topping[];
}
