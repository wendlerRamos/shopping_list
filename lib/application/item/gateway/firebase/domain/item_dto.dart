import 'package:shopping_list/domain/item/model/Item.dart';

class ItemDto {
  String productId;
  String name;
  double quantity;
  String priority;
  double maxValue;
  bool status = false;

  ItemDto(this.productId, this.name, this.quantity, this.priority, this.maxValue, this.status);

  Item toDomain() {
    return Item(productId, name, quantity, priority, maxValue, status);
  }

  Map<String, dynamic> toMap() {
    return {
      "id": productId,
      "name": name,
      "priority": priority,
      "quantity": quantity,
      "maxValue": maxValue,
      "status": status,
    };
  }

  static ItemDto fromDomain(Item item) {
    return ItemDto(item.productId, item.name, item.quantity, item.priority, item.maxValue, item.status);
  }
}
