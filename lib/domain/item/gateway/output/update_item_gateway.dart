import 'package:shopping_list/domain/item/model/update_item_dto.dart';

abstract class UpdateItemGateway{

  void execute(UpdateItemDTO updateItemDTO);

}