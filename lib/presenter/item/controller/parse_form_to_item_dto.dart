import 'package:flutter/cupertino.dart';
import 'package:shopping_list/application/item/gateway/firebase/domain/item_dto.dart';

abstract class ParseFormToItemDto {
  ItemDto execute(
      TextEditingController productController,
      TextEditingController quantityController,
      TextEditingController maximumValueController,
      String priority);
}

class ParseFormToItemDtoImplementation implements ParseFormToItemDto {
  @override
  ItemDto execute(
      TextEditingController productController,
      TextEditingController quantityController,
      TextEditingController maximumValueController,
      String priority) {
    String productName = productController.text;
    double quantity =
        double.parse(quantityController.text.replaceAll(new RegExp(r','), '.'));
    double maximumValue = (maximumValueController.text != "")
        ? double.tryParse(
            maximumValueController.text.replaceAll(new RegExp(r','), '.'))
        : null;
    return ItemDto(null, productName, quantity, priority, maximumValue, false);
  }
}
