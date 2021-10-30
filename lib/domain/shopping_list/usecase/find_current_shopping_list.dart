import 'package:shopping_list/domain/shopping_list/gateway/input/find_current_shopping_list_input.dart';
import 'package:shopping_list/domain/shopping_list/gateway/output/find_current_shopping_list_gateway.dart';
import 'package:shopping_list/domain/shopping_list/model/shopping_list.dart';

class FindCurrentShoppingList implements FindCurrentShoppingListInput {
  final FindCurrentShoppingListGateway findCurrentShoppingListGateway;

  FindCurrentShoppingList(this.findCurrentShoppingListGateway);

  @override
  Future<ShoppingList> execute() async {
    final currentShoppingList = await findCurrentShoppingListGateway.execute();
    return currentShoppingList.getOrElse(() => null);
  }
}
