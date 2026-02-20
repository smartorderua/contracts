@error
model ValidationError {
    code: "VALIDATION_ERROR";
    message: string;
    details: string[];
}

@error
model UnauthorizedError {
    code: "UNAUTHORIZED" | "TOKEN_EXPIRED";
    message: string;
}

@error
model NotFoundError {
    code: "NOT_FOUND" | "TENANT_NOT_FOUND";
    message: string;
}
