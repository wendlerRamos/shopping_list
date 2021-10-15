import 'package:shopping_list/domain/item/model/update_item_dto.dart';

class UpdateItemDtoRequest {
  String id;
  String shoppingListCode;
  bool newStatus;

  UpdateItemDtoRequest(this.id, this.shoppingListCode, this.newStatus);

  UpdateItemDTO toDomain() => UpdateItemDTO(id, shoppingListCode, newStatus);
}
