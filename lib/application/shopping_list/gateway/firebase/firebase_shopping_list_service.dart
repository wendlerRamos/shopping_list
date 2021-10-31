import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_list/application/shopping_list/gateway/firebase/domain/ShoppingListFirestoreResponse.dart';

class FirebaseShoppingListService {

  final Firestore firestore;

  FirebaseShoppingListService(this.firestore);

  Future<ShoppingListFirestoreResponse> saveShoppingList(String code, DateTime createdAt) async {
     await firestore.collection('shoppingLists')
          .document(code)
          .setData({
        'created_at': createdAt,
      });
      return ShoppingListFirestoreResponse(code);
  }

  Future<ShoppingListFirestoreResponse> findByCode(String code) async {
    final list = await Firestore.instance.collection("shoppingLists").document(code).get();
    return (list.data == null) ? null : ShoppingListFirestoreResponse(code);
  }



}