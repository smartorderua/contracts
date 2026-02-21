import "./toppings.tsp";
import "./id.tsp";

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
    id: BsonId;
    tenantId: string;
    imageUrl: string;
    toppings: Topping[];
    createdAt: utcDateTime;
    updatedAt: utcDateTime;
}
