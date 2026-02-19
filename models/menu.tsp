import "./toppings.tsp";

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
    price: int32;

    tenantId: string;
    available: boolean;
    imageUrl: string;
    description: string;
    toppings: Topping[];
    createdAt: utcDateTime;
    updatedAt: utcDateTime;
}
