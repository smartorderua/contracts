import "@typespec/openapi";
import "./id.tsp";

model ToppingInput {
    name: string;

    @minValue(0)
    price: int32;
}

model Topping {
    ...ToppingInput;
    id: UUIDPrimaryKey;
}
