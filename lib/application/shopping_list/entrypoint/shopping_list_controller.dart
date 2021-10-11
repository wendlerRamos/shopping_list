import 'package:dartz/dartz.dart';
import 'package:shopping_list/datas/list_code_store.dart';
import 'package:shopping_list/domain/shopping_list/gateway/input/create_shopping_list_input.dart';
import 'package:shopping_list/domain/shopping_list/model/shopping_list.dart';

abstract class CreateShoppingListController {
  Future<Either<Exception, ShoppingList>> createShoppingList();
}

class ShoppingListController implements CreateShoppingListController {
  final CreateShoppingListInput createShoppingListInput;

  ShoppingListController(this.createShoppingListInput);

  @override
  Future<Either<Exception, ShoppingList>> createShoppingList() async {
    final createdShoppingList = await createShoppingListInput.execute();
    (createdShoppingList.isRight())
        ? ListCode().setCurrentList(createdShoppingList.getOrElse(() => null).code)
        : null;
    return createdShoppingList;
  }
}
