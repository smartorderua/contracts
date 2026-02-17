import "@typespec/openapi";

using OpenAPI;

model ToppingInput {
    @extension("x-faker", "lorem.slug")
    name: string;

    @minValue(0)
    @extension(
        "x-faker",
        #{ `random.number`: #{ min: 9000, max: 40000, presicion: 10 } }
    )
    price: int32;
}

model Topping {
    @extension("x-faker", #{ `random.alpha`: #[16] })
    id: string;

    ...ToppingInput;
}
