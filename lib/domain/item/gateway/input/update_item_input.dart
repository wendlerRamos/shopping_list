import 'package:shopping_list/domain/item/model/update_item_dto.dart';

abstract class UpdateItemInput {
  void execute(UpdateItemDTO updateItemDTO);
}
