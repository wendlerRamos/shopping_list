import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_list/application/item/gateway/firebase/domain/ItemDto.dart';

class FirebaseItemService {
  final Firestore firestore;

  FirebaseItemService(this.firestore);

  void saveItemToList(ItemDto itemDto, String listCode) async {
    print("saving item $itemDto to list $listCode");
    firestore.collection("shoppingLists").document(listCode).collection('products').add(itemDto.toMap());
  }
}
