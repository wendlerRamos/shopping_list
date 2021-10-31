import 'package:shopping_list/domain/shopping_list/model/shopping_list.dart';

abstract class FindCurrentShoppingListInput {
 Future<ShoppingList> execute();
}