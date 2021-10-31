import 'package:shopping_list/domain/item/model/Item.dart';
import 'package:shopping_list/domain/shopping_list/model/shopping_list.dart';

class MockUtil {

  static Item createItem(
      {String productId,
      String name = "Some product",
      double quantity = 1,
      String priority = "NECESSÁRIO",
      double maxValue = 1.99,
      bool status = true}) {
    return Item(productId, name, quantity, priority, maxValue, status);
  }

  static ShoppingList createShoppingList(String code){
    return ShoppingList(code);
  }

}
