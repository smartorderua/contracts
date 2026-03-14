@error
@doc("""
        Validation error, returned when the request body/path fails validation checks.
        The `details` array contains specific validation error messages for each failed field.
    """)
model ValidationError {
    code: "VALIDATION_ERROR";
    message: string;
    details: string[];
}

@error
@doc("""
        Unauthorized error, returned when the request is not authenticated or the token has expired.
    """)
model UnauthorizedError {
    code: "UNAUTHORIZED" | "TOKEN_EXPIRED";
    message: string;
}

@error
model NotFoundError {
    code: "NOT_FOUND" | "TENANT_NOT_FOUND";
    message: string;
}
