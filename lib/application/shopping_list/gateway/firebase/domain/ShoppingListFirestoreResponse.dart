import 'package:shopping_list/domain/shopping_list/model/shopping_list.dart';

class ShoppingListFirestoreResponse {
  String code;

  ShoppingListFirestoreResponse(this.code);

  ShoppingList toDomain(){
    return ShoppingList(this.code);
  }

}