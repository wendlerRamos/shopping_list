import 'package:dartz/dartz.dart';
import 'package:shopping_list/application/shopping_list/gateway/firebase/firebase_shopping_list_service.dart';
import 'package:shopping_list/domain/exceptions/failure_to_create_exception.dart';
import 'package:shopping_list/domain/shopping_list/gateway/output/save_shopping_list_gateway.dart';
import 'package:shopping_list/domain/shopping_list/model/shopping_list.dart';

class SaveShoppingListProvider extends SaveShoppingListGateway {
  final FirebaseShoppingListService firebaseShoppingListService;

  SaveShoppingListProvider(this.firebaseShoppingListService);

  @override
  Future<Either<Exception, ShoppingList>> execute(String code) async {
    try {
      DateTime createdAt = DateTime.now();
      final createdShoppingList =
          await firebaseShoppingListService.saveShoppingList(code, createdAt);
      return Right(createdShoppingList.toDomain());
    } catch (e) {
      return Left(FailureToCreateException(e.toString()));
    }
  }
}
