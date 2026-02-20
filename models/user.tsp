model UserPublic {
    id: BsonId;
    username: string;
    role: "admin" | "staff";
}

model User extends UserPublic {
    @secret
    password: string;

    @secret
    session: {
        refresh: string;
        expiresAt: utcDateTime;
    };
}
