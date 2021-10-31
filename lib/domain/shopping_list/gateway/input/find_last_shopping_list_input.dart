import 'package:shopping_list/domain/shopping_list/model/shopping_list.dart';

abstract class FindLastShoppingListInput {
  Future<List<ShoppingList>> execute();
}