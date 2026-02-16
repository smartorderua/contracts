import "@typespec/http";

using Http;

@service(#{ title: "NovaOrder Service" })
namespace NovaOrder;

model Topping {
  id: string;
  name: string;
  price: int32;
}

model MenuItem {
  id: string;
  name: string;
  price: int32;
  available: boolean;
  imageUrl: string;
  description: string;
  toppings: Topping[];
  createdAt: utcDateTime;
  updatedAt: utcDateTime;
}

model MenuItemCreate {
  name: string;
  price: int32;
  available: boolean;
  description: string;
  toppings: Topping[];
}

model MenuItemList {
  items: MenuItem[];
}

@error
model Error {
  code: int32;
  message: string;
}

@tag("Menu")
@route("/menu")
interface MenuItems {
  @get list(): MenuItemList | Error;
  @get read(@path id: string): MenuItem | Error;

  @post
  @useAuth(BearerAuth)
  create(@body body: MenuItem): MenuItem | Error;

  @patch
  @useAuth(BearerAuth)
  update(
    @path id: string,
    @body body: MergePatchUpdate<MenuItem>,
  ): MenuItem | Error;

  @delete
  @useAuth(BearerAuth)
  delete(@path id: string): void | Error;
}

enum OrderStatus {
  Paid: "paid",
  Pending: "pending",
  Cancelled: "cancelled",
}

model OrderItemCreate {
  tableId: int32;
  menuItemId: string;
  toppings: string[];
}

model OrderItem {
  id: string;
  totalPrice: int32;
  menuItemId: string;
  invoiceId?: string;
}

model OrderItemList {
  items: OrderItem[];
}

@tag("Orders")
@route("/orders")
interface Orders {
  @get read(tableId: int32): OrderItemList | Error;

  @post create(
    @path tableId: int32,
    @body body: OrderItemCreate[],
  ): OrderItem | Error;
}
