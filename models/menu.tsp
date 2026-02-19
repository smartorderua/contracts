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
    id: string;

    name: string;

    @minValue(0)
    @extension(
        "x-faker",
        #{ `random.number`: #{ min: 90000, max: 400000, presicion: 10 } }
    )
    price: int32;

    tenantId: string;
    available: boolean;
    imageUrl: string;
    description: string;
    toppings: Topping[];
    createdAt: utcDateTime;
    updatedAt: utcDateTime;
}
