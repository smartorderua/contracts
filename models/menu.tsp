import "@typespec/openapi";

using OpenAPI;

model MenuItemBase {
    name: string;

    @minValue(0)
    price: int32;

    category: string;
    available: boolean;
    description: string;
}

model MenuItemInput {
    ...MenuItemBase;
    toppings: ToppingInput[];
}

model MenuItem {
    ...MenuItemBase;
    ...EntityBase;

    @extension(ExtraTags, #{ db: "tenant_id" })
    tenantId: string;

    @extension(ExtraTags, #{ db: "image_url" })
    imageUrl: string;

    toppings: Topping[];
}
