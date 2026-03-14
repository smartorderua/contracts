import "@typespec/openapi";
import "./id.tsp";

/**
 * The input model for creating or updating a topping.
 */
model ToppingInput {
    @minLength(1)
    name: string;

    price: Price;
}

model Topping {
    ...ToppingInput;
    id: UUIDPrimaryKey;
}
