import "@typespec/openapi";

using OpenAPI;

model ToppingInput {
    @extension("x-faker", "lorem.slug")
    name: string;

    @minValue(0)
    @extension(
        "x-faker",
        #{ `random.number`: #{ min: 900, max: 4000, precision: 10 } }
    )
    price: int32;
}

model Topping {
    @extension("x-faker", "database.mongodbObjectId")
    id: string;

    ...ToppingInput;
}
