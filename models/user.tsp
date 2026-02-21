model UserPublic {
    id: BsonId;

    @format("email")
    email: string;

    username: string;
    createdAt: utcDateTime;
    updatedAt: utcDateTime;
}

model UserInternal {
    ...UserPublic;

    @secret
    password: string;

    @secret
    session: {
        refresh: string;
        expiresAt: utcDateTime;
    };
}
