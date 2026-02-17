import "./toppings.tsp";
import "@typespec/openapi";

using OpenAPI;

model MenuItemInput {
    name: string;

    @minValue(0)
    price: int32;

    available: boolean;
    description: string;
    toppings: ToppingInput[];
}

model MenuItem {
    @extension("x-faker", "database.mongodbObjectId")
    id: string;

    @extension("x-faker", "lorem.slug")
    name: string;

    @minValue(0)
    @extension(
        "x-faker",
        #{ `random.number`: #{ min: 9000, max: 40000, precision: 10 } }
    )
    price: int32;

    @extension("x-faker", #{ `random.alpha`: #[16] })
    tenantId: string;

    available: boolean;

    @extension(
        "x-faker",
        #{ `helpers.arrayElement`: #[#["https://static.photos/food/640x360"]] }
    )
    imageUrl: string;

    @extension("x-faker", "lorem.sentence")
    description: string;

    category: string;
    toppings: Topping[];
    createdAt: utcDateTime;
    updatedAt: utcDateTime;
}
