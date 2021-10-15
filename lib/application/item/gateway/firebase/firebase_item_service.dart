import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_list/application/item/gateway/firebase/domain/item_dto.dart';
import 'package:shopping_list/domain/item/model/update_item_dto.dart';

class FirebaseItemService {
  final Firestore firestore;

  FirebaseItemService(this.firestore);

  void saveItemToList(ItemDto itemDto, String listCode) async {
    print("saving item $itemDto to list $listCode");
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
}
