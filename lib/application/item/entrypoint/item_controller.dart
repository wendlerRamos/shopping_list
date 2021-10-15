import 'package:shopping_list/application/item/entrypoint/domain/update_item_dto_request.dart';
import 'package:shopping_list/application/item/gateway/firebase/domain/item_dto.dart';
import 'package:shopping_list/domain/item/gateway/input/create_item_input.dart';
import 'package:shopping_list/domain/item/gateway/input/delete_item_input.dart';
import 'package:shopping_list/domain/item/gateway/input/update_item_input.dart';

abstract class CreateItemController {
  Future<bool> createItem(ItemDto itemDto);
}

abstract class UpdateItemStatusController {
  void updateItem(UpdateItemDtoRequest updateItemDtoRequest);
}

abstract class DeleteItemController {
  void deleteItem(String shoppingListCode, String id);
}

class ItemControllerImplementation
    implements CreateItemController, UpdateItemStatusController, DeleteItemController {
  final CreateItemInput createItemInput;
  final UpdateItemInput updateItemInput;
  final DeleteItemInput deleteItemInput;

  ItemControllerImplementation(this.createItemInput, this.updateItemInput, this.deleteItemInput);

  @override
  Future<bool> createItem(ItemDto itemDto) async {
    var createdItem = await createItemInput.execute(itemDto.toDomain());
    return (createdItem.isLeft()) ? false : true;
  }

  @override
  void updateItem(UpdateItemDtoRequest updateItemDtoRequest) {
    updateItemInput.execute(updateItemDtoRequest.toDomain());
  }

  @override
  void deleteItem(String shoppingListCode, String id) {
    deleteItemInput.execute(shoppingListCode, id);
  }
}
