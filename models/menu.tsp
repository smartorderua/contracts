import "@typespec/openapi";

using OpenAPI;

model MenuItemInput {
    name: string;

    @minValue(0)
    price: int32;

    category: string;
    available: boolean;
    description: string;
}

model MenuItem {
    ...MenuItemInput;
    ...EntityBase;

    @extension(ExtraTags, #{ db: "tenant_id" })
    tenantId: string;

    @extension(ExtraTags, #{ db: "image_url" })
    imageUrl: string;
}

model MenuItemWithToppings {
    ...MenuItem;
    toppings: Topping[];
}
