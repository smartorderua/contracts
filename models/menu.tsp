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

    @extension(ExtraTags, #{ bson: "tenant_id,omitempty" })
    tenantId: string;

    @extension(ExtraTags, #{ bson: "image_url,omitempty" })
    imageUrl: string;

    toppings: Topping[];
}
