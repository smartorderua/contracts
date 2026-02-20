import "./toppings.tsp";
import "./id.tsp";

model MenuItemInput {
    name: string;

    @minValue(0)
    price: int32;

    category: string;
    available: boolean;
    description: string;
    toppings: ToppingInput[];
}

model MenuItem {
    // bson id
    id: BsonId;

    name: string;

    @minValue(0)
    price: int32;

    tenantId: string;
    available: boolean;
    category: string;
    imageUrl: string;
    description: string;
    toppings: Topping[];
    createdAt: utcDateTime;
    updatedAt: utcDateTime;
}
