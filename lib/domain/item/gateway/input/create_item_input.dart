import 'package:dartz/dartz.dart';
import 'package:shopping_list/domain/exceptions/failure.dart';
import 'package:shopping_list/domain/item/model/Item.dart';

abstract class CreateItemInput {

  Future<Either<Failure, Item>> execute(Item item);

}