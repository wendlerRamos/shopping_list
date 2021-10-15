import 'package:shopping_list/domain/item/gateway/input/delete_item_input.dart';
import 'package:shopping_list/domain/item/gateway/output/delete_item_gateway.dart';

class DeleteItem implements DeleteItemInput {
  final DeleteItemGateway deleteItemGateway;

  DeleteItem(this.deleteItemGateway);

  @override
  void execute(String shoppingListCode, String id) {
    deleteItemGateway.execute(shoppingListCode, id);
  }

}