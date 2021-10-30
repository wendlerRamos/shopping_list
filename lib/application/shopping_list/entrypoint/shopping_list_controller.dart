import 'package:dartz/dartz.dart';
import 'package:shopping_list/domain/exceptions/not_found_exception.dart';
import 'package:shopping_list/domain/shopping_list/gateway/input/create_shopping_list_input.dart';
import 'package:shopping_list/domain/shopping_list/gateway/input/find_current_shopping_list_input.dart';
import 'package:shopping_list/domain/shopping_list/gateway/input/find_last_shopping_list_input.dart';
import 'package:shopping_list/domain/shopping_list/gateway/input/find_shopping_list_by_code_input.dart';
import 'package:shopping_list/domain/shopping_list/model/shopping_list.dart';

abstract class CreateShoppingListController {
  Future<Either<Exception, ShoppingList>> createShoppingList();
}

abstract class FindLastShoppingListsController {
  Future<List<ShoppingList>> find();
}

abstract class FindShoppingListByCodeController {
  Future<Either<Exception, ShoppingList>> findByCode(String code);
}

abstract class FindCurrentShoppingListController {
  Future<Either<Exception, ShoppingList>> findCurrent();
}

class ShoppingListController
    implements
        CreateShoppingListController,
        FindLastShoppingListsController,
        FindShoppingListByCodeController,
        FindCurrentShoppingListController {
  final CreateShoppingListInput createShoppingListInput;
  final FindLastShoppingListInput findLastShoppingListInput;
  final FindShoppingListByCodeInput findShoppingListByCodeInput;
  final FindCurrentShoppingListInput findCurrentShoppingListInput;

  ShoppingListController(this.createShoppingListInput, this.findLastShoppingListInput,
      this.findShoppingListByCodeInput, this.findCurrentShoppingListInput);

  @override
  Future<Either<Exception, ShoppingList>> createShoppingList() async {
    final createdShoppingList = await createShoppingListInput.execute();
    return createdShoppingList;
  }

  @override
  Future<List<ShoppingList>> find() async {
    return await findLastShoppingListInput.execute();
  }

  @override
  Future<Either<Exception, ShoppingList>> findByCode(String code) async {
    return await findShoppingListByCodeInput.execute(code);
  }

  @override
  Future<Either<Exception, ShoppingList>> findCurrent() async {
    try {
      final currentShoppingList = await findCurrentShoppingListInput.execute();
      return (currentShoppingList == null)
          ? Left(NotFoundException("There is not a current list"))
          : Right(currentShoppingList);
    } catch (e) {
      return Left(NotFoundException("Failure to find current shopping list"));
    }
  }
}
