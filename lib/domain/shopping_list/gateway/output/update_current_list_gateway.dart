import 'package:shopping_list/domain/shopping_list/model/shopping_list.dart';

abstract class UpdateCurrentShoppingListGateway {
  void execute(ShoppingList shoppingList);
}