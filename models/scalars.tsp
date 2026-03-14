@minLength(10)
@format("password")
scalar Password extends string;

@format("email")
scalar Email extends string;

@minLength(4)
@maxLength(20)
@doc("""
      A unique name for a tenant, used in the URL paths/subdomains. 
      Should only contain lowercase letters, numbers, no special characters.
      Reserved keywords: "admin", "test", "docs", "nova"
    """)
scalar TenantUniqueId extends string;

@minValue(0)
@doc("Price in kopiykas (cents) to avoid floating point issues")
scalar Price extends int32;
