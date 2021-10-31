import 'package:shopping_list/application/item/gateway/firebase/firebase_item_service.dart';
import 'package:shopping_list/domain/item/gateway/output/update_item_gateway.dart';
import 'package:shopping_list/domain/item/model/update_item_dto.dart';

class UpdateItemProvider implements UpdateItemGateway {
  final FirebaseItemService firebaseItemService;

  UpdateItemProvider(this.firebaseItemService);

  @override
  void execute(UpdateItemDTO updateItemDTO) {
    firebaseItemService.updateItem(updateItemDTO);
  }
}
