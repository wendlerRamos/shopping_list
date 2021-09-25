
import 'package:shopping_list/application/item/gateway/firebase/domain/ItemDto.dart';
import 'package:shopping_list/domain/item/gateway/input/create_item_input.dart';
import 'package:shopping_list/domain/item/model/Item.dart';

abstract class ItemController {

  Future<Item> createItem(ItemDto itemDto);

}

class ItemControllerImplementation implements ItemController {

  final CreateItemInput createItemInput;

  ItemControllerImplementation(this.createItemInput);

  Future<Item> createItem(ItemDto itemDto) async {
    createItemInput.execute(itemDto.toDomain());
    //TODO("Finish here")
  }

}
