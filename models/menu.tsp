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
    // bson id
    @extension("x-faker", #{ `random.alpha`: #[16] })
    id: string;

    @extension("x-faker", "lorem.slug")
    name: string;

    @minValue(0)
    @extension(
        "x-faker",
        #{ `random.number`: #{ min: 90000, max: 400000, presicion: 10 } }
    )
    price: int32;

    @extension("x-faker", #{ `random.alpha`: #[16] })
    tenantId: string;

    available: boolean;

    @extension("x-faker", "image.food")
    imageUrl: string;

    @extension("x-faker", "lorem.sentence")
    description: string;

    toppings: Topping[];
    createdAt: utcDateTime;
    updatedAt: utcDateTime;
}
