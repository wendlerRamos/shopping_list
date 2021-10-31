import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_list/application/item/gateway/firebase/domain/item_dto.dart';
import 'package:shopping_list/domain/item/model/update_item_dto.dart';

class FirebaseItemService {
  final Firestore firestore;

  FirebaseItemService(this.firestore);

  void saveItemToList(ItemDto itemDto, String listCode) async {
    firestore
        .collection("shoppingLists")
        .document(listCode)
        .collection('products')
        .add(itemDto.toMap());
  }

  void updateItem(UpdateItemDTO updateItemDTO) async {
    firestore
        .collection("shoppingLists")
        .document(updateItemDTO.shoppingListCode)
        .collection('products')
        .document(updateItemDTO.id)
        .updateData({
      "status": updateItemDTO.newStatus,
    });
  }

  void deleteItem(String shoppingListCode, String id) {
    firestore
        .collection("shoppingLists")
        .document(shoppingListCode)
        .collection('products')
        .document(id)
        .delete();
  }

  Stream<QuerySnapshot> findItemsByShoppingList(String shoppingListCode) {
    return firestore
        .collection('shoppingLists')
        .document(shoppingListCode)
        .collection('products')
        .orderBy('status', descending: false)
        .orderBy('name', descending: false)
        .snapshots();
  }
}
