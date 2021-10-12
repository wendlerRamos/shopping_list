import 'package:dartz/dartz.dart';
import 'package:shopping_list/domain/shopping_list/model/shopping_list.dart';

abstract class FindShoppingListByCodeInput {
  Future<Either<Exception, ShoppingList>> execute(String code);
}
