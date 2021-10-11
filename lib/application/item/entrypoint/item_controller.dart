
import 'package:shopping_list/application/item/gateway/firebase/domain/ItemDto.dart';
import 'package:shopping_list/domain/item/gateway/input/create_item_input.dart';

abstract class ItemController {

  Future<bool> createItem(ItemDto itemDto);

}

class ItemControllerImplementation implements ItemController {

  final CreateItemInput createItemInput;

  ItemControllerImplementation(this.createItemInput);

  Future<bool> createItem(ItemDto itemDto) async {
    var createdItem = await createItemInput.execute(itemDto.toDomain());
    return (createdItem.isLeft()) ? false : true;
  }

}
