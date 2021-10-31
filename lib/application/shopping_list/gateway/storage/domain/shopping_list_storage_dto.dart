import 'package:shopping_list/domain/shopping_list/model/shopping_list.dart';

class ShoppingListStorageDto {
  String code;

  ShoppingListStorageDto(this.code);

  ShoppingList toDomain() {
    return ShoppingList(code);
  }
}
