import "@typespec/http";

using Http;

@service(#{ title: "NovaOrder Service" })
namespace NovaOrder;

model ToppingInput {
  name: string;
  price: int32;
}

model Topping {
  id: string;
  ...ToppingInput;
}

model MenuItemInput {
  name: string;
  price: int32;
  available: boolean;
  description: string;
  toppings: ToppingInput[];
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
  create(@body body: MenuItemInput): MenuItem | Error;

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

model OrderItemInput {
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
    @body body: OrderItemInput[],
  ): OrderItem | Error;
}
