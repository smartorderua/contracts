import "@typespec/openapi";

using OpenAPI;

model UserPublic {
    ...EntityBase;
    email: Email;

    @minLength(4)
    username: string;
}

model UserInternal {
    ...UserPublic;

    @secret
    password: Password;

    @secret
    session: {
        refresh: string;

        @extension(ExtraTags, #{ db: "expires_at,omitempty" })
        expiresAt: utcDateTime;
    };
}
