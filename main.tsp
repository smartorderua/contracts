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
  email: string;
  password: string;
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
  signUp(@body body: SignUpRequest): {
    @statusCode statusCode: 201;
    @body response: UserPublic;
  } | {
    @statusCode statusCode: 400;
    @body error: ValidationError;
  };

  @post
  @route("/login")
  login(@body body: LoginRequest): {
    @statusCode statusCode: 200;
    @body response: LoginResponse;
  } | {
    @statusCode statusCode: 401;
    @body error: UnauthorizedError;
  };

  @post
  @route("/refresh")
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
  me(): {
    @statusCode statusCode: 200;
    @body response: UserPublic;
  } | {
    @statusCode statusCode: 401;
    @body error: UnauthorizedError;
  };
}

model UpdateItemImageResponse {
  imageUrl: string;
}

@tag("Menu")
@route("/menu")
interface Menu {
  @get
  @route("/{tenantId}/items")
  listItems(...TenantParams): {
    @statusCode statusCode: 200;
    @body items: MenuItem[];
  } | {
    @statusCode statusCode: 404;
    @body error: NotFoundError;
  };

  @get
  @route("/{tenantId}/items/{id}")
  readItem(...TenantParams, @path id: string): {
    @statusCode statusCode: 200;
    @body item: MenuItem;
  } | {
    @statusCode statusCode: 404;
    @body error: NotFoundError;
  };

  @post
  @route("/{tenantId}/items")
  @useAuth(BearerAuth)
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
}

@tag("Orders")
@route("/orders")
interface Orders {
  @get read(...OrderParams): {
    @statusCode statusCode: 200;
    @body items: Order[];
  } | {
    @statusCode statusCode: 404;
    @body error: NotFoundError;
  } | {
    // occurs when the provided orderId is not valid
    @body error: ValidationError;

    @statusCode statusCode: 400;
  };

  // Create new order for a specific tenant and table
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
