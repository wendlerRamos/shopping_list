import 'package:shopping_list/datas/list_code_store.dart';
import 'package:shopping_list/domain/shopping_list/gateway/output/update_current_list_gateway.dart';
import 'package:shopping_list/domain/shopping_list/model/shopping_list.dart';

class UpdateCurrentShoppingListProvider implements UpdateCurrentShoppingListGateway {

  @override
  void execute(ShoppingList shoppingList) {
    ListCode().setCurrentList(shoppingList.code);
  }

}