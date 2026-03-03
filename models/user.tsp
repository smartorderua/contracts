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
    @extension(ExtraTags, #{ db: "refresh_token" })
    refreshToken: string;

    @secret
    @extension(ExtraTags, #{ db: "session_expires_at" })
    sessionExpiresAt: utcDateTime;
}
