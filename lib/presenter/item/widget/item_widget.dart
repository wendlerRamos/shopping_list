import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopping_list/application/item/entrypoint/domain/update_item_dto_request.dart';
import 'package:shopping_list/application/item/entrypoint/item_controller.dart';
import 'package:shopping_list/datas/item_data.dart';
import 'package:shopping_list/datas/list_code_store.dart';
import 'package:shopping_list/models/list_model.dart';
import 'package:shopping_list/presenter/util/controller/parse_string_to_monetary_value.dart';

class ItemWidget extends StatefulWidget {
  final ItemList itemList;

  ItemWidget({Key key, @required this.itemList}) : super(key: key);

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  String _listCode = ListCode().getCurrentList();
  final parseStringToMonetaryValue = Modular.get<ParseStringToMonetaryValue>();
  final itemController = Modular.get<UpdateItemStatusController>();

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
          itemController.updateItem(updateItemDtoRequest);
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
        ListModel.removeItem2(widget.itemList, _listCode);
      },
    );
  }

  Color getColorByPriority() {
    return (widget.itemList.priority == "NECESSARIO")
        ? Color.fromARGB(255, 0, 38, 66)
        : Color.fromARGB(255, 236, 78, 32);
  }
}
