import "@typespec/http";
import "@typespec/versioning";
import "./models";

using Http;
using Versioning;

@service(#{ title: "NovaOrder Service" })
@versioned(Versions)
namespace NovaOrder;

enum Versions {
  v1: "1.0",
}

model TenantParams {
  @path tenantId: string;
}

@tag("Menu")
@route("/menu")
interface MenuItems {
  @get list(...TenantParams): {
    @statusCode statusCode: 200;
    @body items: MenuItem[];
  } | {
    @statusCode statusCode: 404;
    @body error: TenantNotFoundError;
  };

  @get read(...TenantParams, @path menuItemId: string): {
    @statusCode statusCode: 200;
    @body item: MenuItem;
  } | {
    @statusCode statusCode: 404;
    @body error: NotFoundError;
  } | {
    @statusCode statusCode: 404;
    @body error: TenantNotFoundError;
  };

  @post
  @useAuth(BearerAuth)
  create(...TenantParams, @body body: MenuItemInput):
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
      }
    | {
        @statusCode statusCode: 404;
        @body error: TenantNotFoundError;
      };

  @patch
  @useAuth(BearerAuth)
  update(
    ...TenantParams,
    @path id: string,
    @body body: MergePatchUpdate<MenuItem>,
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
      }
    | {
        @statusCode statusCode: 404;
        @body error: TenantNotFoundError;
      };

  @delete
  @useAuth(BearerAuth)
  delete(...TenantParams, @path id: string):
    | {
        @statusCode statusCode: 204;
      }
    | {
        @statusCode statusCode: 401;
        @body error: UnauthorizedError;
      }
    | {
        @statusCode statusCode: 404;
        @body error: NotFoundError;
      }
    | {
        @statusCode statusCode: 404;
        @body error: TenantNotFoundError;
      };
}

model OrderParams {
  ...TenantParams;
  @path tableId: int32;
}

@tag("Orders")
@route("/orders")
interface Orders {
  // List all orders for a specific tenant and table
  // Acts like a table session
  @get read(...OrderParams): {
    @statusCode statusCode: 200;
    @body items: OrderItem[];
  } | {
    @statusCode statusCode: 404;
    @body error: NotFoundError;
  } | {
    @statusCode statusCode: 404;
    @body error: TenantNotFoundError;
  };

  // Create new order for a specific tenant and table
  @post create(...OrderParams, @body body: OrderItemInput[]):
    | {
        @statusCode statusCode: 201;
        @body createdItems: OrderItem[];
      }
    | {
        @statusCode statusCode: 400;
        @body error: ValidationError;
      }
    | {
        @statusCode statusCode: 404;
        @body error: NotFoundError;
      }
    | {
        @statusCode statusCode: 404;
        @body error: TenantNotFoundError;
      };
}
