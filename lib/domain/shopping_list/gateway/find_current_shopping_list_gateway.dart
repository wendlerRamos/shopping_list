import 'package:dartz/dartz.dart';
import 'package:shopping_list/domain/exceptions/not_found_exception.dart';
import 'package:shopping_list/domain/shopping_list/model/shopping_list.dart';

abstract class FindCurrentShoppingListGateway {

  Future<Either<NotFoundException, ShoppingList>> execute();

}