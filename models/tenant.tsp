model TenantInput {
    name: string;
    uniqueId: string;
}

model Tenant {
    id: BsonId;
    name: string;
    uniqueId: string;
    admins: string[];
    staff: string[];
    createdAt: utcDateTime;
    updatedAt: utcDateTime;
}
