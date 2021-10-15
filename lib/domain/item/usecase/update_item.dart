import 'package:shopping_list/domain/item/gateway/input/update_item_input.dart';
import 'package:shopping_list/domain/item/gateway/output/update_item_gateway.dart';
import 'package:shopping_list/domain/item/model/update_item_dto.dart';

class UpdateItem implements UpdateItemInput {
  final UpdateItemGateway updateItemGateway;

  UpdateItem(this.updateItemGateway);

  @override
  void execute(UpdateItemDTO updateItemDTO) {
    updateItemGateway.execute(updateItemDTO);
  }
}
