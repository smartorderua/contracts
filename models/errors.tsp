@error
model ValidationError {
    code: "VALIDATION_ERROR";
    message: string;
    details: string[];
}

@error
model UnauthorizedError {
    code: "UNAUTHORIZED";
    message: string;
}

@error
model TenantNotFoundError {
    code: "TENANT_NOT_FOUND";
    message: string;
}

@error
model NotFoundError {
    code: "NOT_FOUND";
    message: string;
}
