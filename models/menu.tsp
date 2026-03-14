import "@typespec/openapi";

using OpenAPI;

/**
 * The input model for creating or updating a menu item.
 * An image can be uploaded separately after creation.
 */
model MenuItemInput {
    name: string;
    price: Price;
    category: string;
    available: boolean;
    description: string;
}

model MenuItem {
    ...MenuItemInput;
    ...EntityBase;

    @extension(ExtraTags, #{ db: "tenant_id" })
    tenantId: TenantUniqueId;

    @extension(ExtraTags, #{ db: "image_url" })
    imageUrl: url;
}

model MenuItemWithToppings {
    ...MenuItem;
    toppings: Topping[];
}
