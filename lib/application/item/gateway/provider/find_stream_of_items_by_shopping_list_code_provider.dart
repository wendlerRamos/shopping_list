import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_list/application/item/gateway/firebase/firebase_item_service.dart';

abstract class FindItemsByShoppingListCodeInput {
  Stream<QuerySnapshot> execute(String shoppingListCode);
}

class FindItemsByShoppingListCodeProvider
    implements FindItemsByShoppingListCodeInput {
  final FirebaseItemService firebaseItemService;

  FindItemsByShoppingListCodeProvider(this.firebaseItemService);

  @override
  Stream<QuerySnapshot> execute(String shoppingListCode) {
    return firebaseItemService.findItemsByShoppingList(shoppingListCode);
  }
}
