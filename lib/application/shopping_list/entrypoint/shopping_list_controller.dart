import 'package:dartz/dartz.dart';
import 'package:shopping_list/datas/list_code_store.dart';
import 'package:shopping_list/domain/shopping_list/gateway/input/create_shopping_list_input.dart';
import 'package:shopping_list/domain/shopping_list/gateway/input/find_last_shopping_list_input.dart';
import 'package:shopping_list/domain/shopping_list/model/shopping_list.dart';

abstract class CreateShoppingListController {
  Future<Either<Exception, ShoppingList>> createShoppingList();
}

abstract class FindLastShoppingListsController {
  Future<List<ShoppingList>> find();
}

class ShoppingListController
    implements CreateShoppingListController, FindLastShoppingListsController {
  final CreateShoppingListInput createShoppingListInput;
  final FindLastShoppingListInput findLastShoppingListInput;

  ShoppingListController(this.createShoppingListInput, this.findLastShoppingListInput);

  @override
  Future<Either<Exception, ShoppingList>> createShoppingList() async {
    final createdShoppingList = await createShoppingListInput.execute();
    if (createdShoppingList.isRight()) {
      ListCode().setCurrentList(createdShoppingList.getOrElse(() => null).code);
    }
    return createdShoppingList;
  }

  @override
  Future<List<ShoppingList>> find() async {
    return await findLastShoppingListInput.execute();
  }
}
