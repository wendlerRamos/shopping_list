import 'package:shopping_list/domain/shopping_list/gateway/input/find_last_shopping_list_input.dart';
import 'package:shopping_list/domain/shopping_list/gateway/output/find_last_shopping_lists_gateway.dart';
import 'package:shopping_list/domain/shopping_list/model/shopping_list.dart';

class FindLastShoppingLists implements FindLastShoppingListInput {
  final FindLastShoppingListsGateway findLastShoppingListsGateway;

  FindLastShoppingLists(this.findLastShoppingListsGateway);

  @override
  Future<List<ShoppingList>> execute() async {
    try{
      return await findLastShoppingListsGateway.execute();
    }catch(e){
      return [];
    }
  }
}
