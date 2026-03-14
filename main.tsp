import "@typespec/http";
import "@typespec/versioning";
import "./http";
import "./models";

using Versioning;
using Http;

@versioned(Versions)
@service(#{ title: "NovaOrder Service" })
namespace NovaOrder;

enum Versions {
  v1: "1.0",
}

model LoginResponse {
  accessToken: string;
  refreshToken: string;
}

model LoginRequest {
  email: Email;
  password: Password;
}

model SignUpRequest {
  ...LoginRequest;
  username: string;
}

@tag("Auth")
@route("/auth")
interface Auth {
  @post
  @route("/signup")
  @doc("Register a new user with email and password")
  signUp(@body body: SignUpRequest): {
    @statusCode statusCode: 201;
    @body response: UserPublic;
  } | {
    @statusCode statusCode: 400;

    @body
    @doc("Occurs when the email is already registered or input validation fails")
    error: ValidationError;
  };

  @post
  @route("/login")
  @doc("""
          Authenticate a user and return access and refresh tokens.
          Access token is then used to access protected endpoints using BearerAuth.
          Refresh token can be used to obtain a new pair of tokens using /refresh endpoint
           - Returns 200 with tokens if credentials are valid.
           - Returns 401 if credentials are invalid.
    """)
  login(@body body: LoginRequest): {
    @statusCode statusCode: 200;
    @body response: LoginResponse;
  } | {
    @statusCode statusCode: 401;
    @body error: UnauthorizedError;
  };

  @post
  @route("/refresh")
  @doc("""
          Returns a new pair of access and refresh tokens given a valid refresh token.
           - Returns 200 with new tokens if the refresh token is valid.
           - Returns 401 if the refresh token is invalid or expired.
    """)
  refresh(
    @body body: {
      refreshToken: string;
    },
  ): {
    @statusCode statusCode: 200;
    @body response: LoginResponse;
  } | {
    @statusCode statusCode: 401;
    @body error: UnauthorizedError;
  };

  @get
  @route("/me")
  @useAuth(BearerAuth)
  @doc("""
          Get the currently authenticated user's information.
           - Returns 200 with user info if the access token is valid.
           - Returns 401 if the access token is missing, invalid, or expired.
    """)
  me(): {
    @statusCode statusCode: 200;
    @body response: UserPublic;
  } | {
    @statusCode statusCode: 401;
    @body error: UnauthorizedError;
  };
}

model UpdateItemImageResponse {
  imageUrl: url;
}

@tag("Menu")
@route("/menu")
interface Menu {
  @get
  @route("/{tenantId}/items")
  @doc("""
          Get all menu items for a specific tenant, including their toppings.
           - Returns 200 with the list of menu items if the tenant exists.
           - Returns 404 if the tenant does not exist.
    """)
  listItems(...TenantParams): {
    @statusCode statusCode: 200;
    @body items: MenuItemWithToppings[];
  } | {
    @statusCode statusCode: 404;
    @body error: NotFoundError;
  };

  @post
  @route("/{tenantId}/items")
  @useAuth(BearerAuth)
  @doc("""
          Create a new menu item for a specified tenant.
           - Returns 201 with the created menu item if the request is valid.
           - Returns 400 if the request body fails validation checks.
           - Returns 401 if the request is not authenticated or the token has expired or user's permissions are insufficient.
           - Returns 404 if the tenant does not exist.
    """)
  createItem(...TenantParams, @body body: MenuItemInput):
    | {
        @statusCode statusCode: 201;
        @body createdItem: MenuItem;
      }
    | {
        @statusCode statusCode: 400;
        @body error: ValidationError;
      }
    | {
        @statusCode statusCode: 401;
        @body error: UnauthorizedError;
      }
    | {
        @statusCode statusCode: 404;
        @body error: NotFoundError;
      };

  @post
  @useAuth(BearerAuth)
  @route("/{tenantId}/items/{id}/image")
  @doc("""
          Upload or update the image for a specific menu item.
           - Returns 200 with the new image URL if the upload is successful.
           - Returns 400 if the request fails validation checks (e.g., missing file).
           - Returns 401 if the request is not authenticated or the token has expired or user's permissions are insufficient.
           - Returns 404 if the tenant or menu item does not exist.
    """)
  updateItemImage(
    ...TenantParams,
    @path id: string,
    @multipartBody fields: {
      file: HttpPart<File>;
    },
  ):
    | {
        @statusCode statusCode: 200;
        @body resp: UpdateItemImageResponse;
      }
    | {
        @statusCode statusCode: 400;
        @body error: ValidationError;
      }
    | {
        @statusCode statusCode: 401;
        @body error: UnauthorizedError;
      }
    | {
        @statusCode statusCode: 404;
        @body error: NotFoundError;
      };

  @patch
  @useAuth(BearerAuth)
  @route("/{tenantId}/items/{id}")
  updateItem(
    ...TenantParams,
    @path id: string,
    @body body: MergePatchUpdate<MenuItemInput>,
  ):
    | {
        @statusCode statusCode: 200;
        @body updatedItem: MenuItem;
      }
    | {
        @statusCode statusCode: 400;
        @body error: ValidationError;
      }
    | {
        @statusCode statusCode: 401;
        @body error: UnauthorizedError;
      }
    | {
        @statusCode statusCode: 404;
        @body error: NotFoundError;
      };

  @delete
  @useAuth(BearerAuth)
  @route("/{tenantId}/items/{id}")
  deleteItem(...TenantParams, @path id: string): {
    @statusCode statusCode: 204;
  } | {
    @statusCode statusCode: 401;
    @body error: UnauthorizedError;
  } | {
    @statusCode statusCode: 404;
    @body error: NotFoundError;
  };

  @get
  @route("/{tenantId}/items/{id}/toppings")
  listToppings(...TenantParams, @path id: string): {
    @statusCode statusCode: 200;
    @body toppings: Topping[];
  } | {
    @statusCode statusCode: 404;
    @body error: NotFoundError;
  };

  @post
  @useAuth(BearerAuth)
  @route("/{tenantId}/items/{id}/toppings")
  addToppings(
    ...TenantParams,
    @path id: string,
    @body body: {
      toppings: ToppingInput[];
    },
  ):
    | {
        @statusCode statusCode: 201;
        @body createdToppings: Topping[];
      }
    | {
        @statusCode statusCode: 400;
        @body error: ValidationError;
      }
    | {
        @statusCode statusCode: 401;
        @body error: UnauthorizedError;
      }
    | {
        @statusCode statusCode: 404;
        @body error: NotFoundError;
      };

  @delete
  @useAuth(BearerAuth)
  @route("/{tenantId}/items/{id}/toppings/{toppingId}")
  deleteTopping(...TenantParams, @path id: string, @path toppingId: string): {
    @statusCode statusCode: 204;
  } | {
    @statusCode statusCode: 401;
    @body error: UnauthorizedError;
  } | {
    @statusCode statusCode: 404;
    @body error: NotFoundError;
  };
}

@tag("Orders")
@route("/orders")
interface Orders {
  @get read(...OrderParams): {
    @statusCode statusCode: 200;
    @body order: Order;
  } | {
    @statusCode statusCode: 404;
    @body error: NotFoundError;
  } | {
    @body error: ValidationError;
    @statusCode statusCode: 400;
  };

  @post create(...TenantParams, @body body: OrderInput): {
    @statusCode statusCode: 201;
    @body resp: Order;
  } | {
    @statusCode statusCode: 400;
    @body error: ValidationError;
  } | {
    @statusCode statusCode: 404;
    @body error: NotFoundError;
  };
}

model StaffInput {
  emails: string[];
}

@tag("Tenants")
@route("/tenants")
interface Tenants {
  @get
  @useAuth(BearerAuth)
  find(@path tenantId: string): {
    @statusCode statusCode: 200;
    @body tenant: Tenant;
  } | {
    @statusCode statusCode: 401;
    @body error: UnauthorizedError;
  } | {
    @statusCode statusCode: 404;
    @body error: NotFoundError;
  };

  @post
  @useAuth(BearerAuth)
  create(@body body: TenantInput): {
    @statusCode statusCode: 201;
    @body tenant: Tenant;
  } | {
    @statusCode statusCode: 400;
    @body error: ValidationError;
  } | {
    @statusCode statusCode: 401;
    @body error: UnauthorizedError;
  };

  @post
  @useAuth(BearerAuth)
  @route("/{tenantId}/staff")
  addStaff(...TenantParams, @body body: StaffInput):
    | {
        @statusCode statusCode: 200;
      }
    | {
        @statusCode statusCode: 400;
        @body error: ValidationError;
      }
    | {
        @statusCode statusCode: 401;
        @body error: UnauthorizedError;
      }
    | {
        @statusCode statusCode: 404;
        @body error: NotFoundError;
      };
}
