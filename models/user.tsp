@secret
scalar Password extends string;

model UserPublic {
    id: string;
    username: string;
    role: "admin" | "staff";
}

model User extends UserPublic {
    password: Password;
}
