import 'package:dartz/dartz.dart';
import 'package:shopping_list/domain/shopping_list/model/shopping_list.dart';

abstract class SaveShoppingListGateway {

  Future<Either<Exception, ShoppingList>> execute(String code);

}