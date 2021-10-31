import 'package:dartz/dartz.dart';
import 'package:shopping_list/domain/shopping_list/gateway/input/find_shopping_list_by_code_input.dart';
import 'package:shopping_list/domain/shopping_list/gateway/output/find_shopping_list_by_code_gateway.dart';
import 'package:shopping_list/domain/shopping_list/gateway/output/update_current_list_gateway.dart';
import 'package:shopping_list/domain/shopping_list/model/shopping_list.dart';

class FindShoppingListByCode implements FindShoppingListByCodeInput {
  final FindShoppingListByCodeGateway findShoppingListByCodeGateway;
  final UpdateCurrentShoppingListGateway updateCurrentShoppingListGateway;

  FindShoppingListByCode(this.findShoppingListByCodeGateway, this.updateCurrentShoppingListGateway);

  @override
  Future<Either<Exception, ShoppingList>> execute(String code) async {
    final shoppingList = await findShoppingListByCodeGateway.execute(code);
    if (shoppingList.isRight()) {
      updateCurrentShoppingListGateway.execute(shoppingList.getOrElse(() => null));
    }
    return shoppingList;
  }
}
