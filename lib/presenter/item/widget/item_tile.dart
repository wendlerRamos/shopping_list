import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopping_list/application/item/entrypoint/domain/update_item_dto_request.dart';
import 'package:shopping_list/application/item/entrypoint/item_controller.dart';
import 'package:shopping_list/presenter/item/model/item_data.dart';
import 'package:shopping_list/presenter/core/controller/shopping_list_store.dart';
import 'package:shopping_list/presenter/util/controller/ColorManager.dart';
import 'package:shopping_list/presenter/util/controller/parse_string_to_monetary_value.dart';

class ItemTile extends StatefulWidget {
  final ItemList itemList;

  ItemTile({Key key, @required this.itemList}) : super(key: key);

  @override
  _ItemTileState createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  String _listCode = ShoppingListStore().getCurrentList();
  final parseStringToMonetaryValue = Modular.get<ParseStringToMonetaryValue>();
  final updateItemController = Modular.get<UpdateItemStatusController>();
  final deleteItemController = Modular.get<DeleteItemController>();

  @override
  Widget build(BuildContext context) {
    bool status = widget.itemList.status;
    String _maxValueText = (widget.itemList.maxValue != null)
        ? "\t Valor Máx: " + parseStringToMonetaryValue.execute(widget.itemList.maxValue.toString())
        : "";
    String quantityText = widget.itemList.quantity.toString().replaceAll(".", ",");
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment(-0.8, 0.0),
          child: Icon(Icons.delete, color: Colors.white),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: CheckboxListTile(
        activeColor: getColorByPriority(),
        checkColor: Colors.white,
        onChanged: (c) {
          status = !status;
          final updateItemDtoRequest =
              UpdateItemDtoRequest(widget.itemList.productId, _listCode, status);
          updateItemController.updateItem(updateItemDtoRequest);
        },
        value: status,
        title: Text(
          "${widget.itemList.name}",
          style: TextStyle(
            color: getColorByPriority(),
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Card(
              color: Colors.grey[500],
              child: Padding(
                padding: EdgeInsets.only(top: 1.5, bottom: 1.5, left: 3.5, right: 3.5),
                child: Text(
                  '$quantityText UN',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
            ),
            Text(_maxValueText),
          ],
        ),
        secondary: CircleAvatar(
          backgroundColor: getColorByPriority(),
          child: Icon(
            widget.itemList.status ? Icons.check : Icons.add_shopping_cart,
            color: Colors.white,
          ),
        ),
      ),
      onDismissed: (direction) {
        deleteItemController.deleteItem(_listCode, widget.itemList.productId);
      },
    );
  }

  Color getColorByPriority() {
    return (widget.itemList.priority == "NECESSARIO")
        ? ColorManager.getBlueColor()
        : ColorManager.getOrangeColor();
  }
}
