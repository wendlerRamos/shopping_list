import 'package:dartz/dartz.dart';
import 'package:shopping_list/application/shopping_list/gateway/firebase/firebase_shopping_list_service.dart';
import 'package:shopping_list/domain/exceptions/failure_to_create_exception.dart';
import 'package:shopping_list/domain/exceptions/not_found_exception.dart';
import 'package:shopping_list/domain/shopping_list/gateway/output/find_shopping_list_by_code_gateway.dart';
import 'package:shopping_list/domain/shopping_list/model/shopping_list.dart';

class FindShoppingListByCodeProvider implements FindShoppingListByCodeGateway {

  final FirebaseShoppingListService firebaseShoppingListService;

  FindShoppingListByCodeProvider(this.firebaseShoppingListService);

  @override
  Future<Either<Exception, ShoppingList>> execute(String code) async{
    try{
      final shoppingList = await firebaseShoppingListService.findByCode(code);
      if (shoppingList == null) return Left(NotFoundException());
      return Right(shoppingList.toDomain());
    }catch(e){
      return Left(FailureToCreateException(e.toString()));
    }
  }

}