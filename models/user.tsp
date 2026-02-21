import "@typespec/openapi";

using OpenAPI;

model UserPublic {
    ...EntityBase;

    @format("email")
    email: string;

    username: string;
}

model UserInternal {
    ...UserPublic;

    @secret
    password: string;

    @secret
    session: {
        refresh: string;

        @extension(ExtraTags, #{ bson: "expires_at,omitempty" })
        expiresAt: utcDateTime;
    };
}
