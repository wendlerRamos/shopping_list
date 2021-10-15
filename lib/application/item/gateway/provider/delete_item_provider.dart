import 'package:shopping_list/application/item/gateway/firebase/firebase_item_service.dart';
import 'package:shopping_list/domain/item/gateway/output/delete_item_gateway.dart';

class DeleteItemProvider implements DeleteItemGateway {
  final FirebaseItemService firebaseItemService;

  DeleteItemProvider(this.firebaseItemService);

  @override
  void execute(String shoppingListCode, String id) {
    firebaseItemService.deleteItem(shoppingListCode, id);
  }
}
