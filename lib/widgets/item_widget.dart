import 'package:flutter/material.dart';
import 'package:shopping_list/datas/item_data.dart';
import 'package:shopping_list/models/list_model.dart';

class ItemWidget extends StatelessWidget {
  final ItemList itemList;
  ItemWidget(this.itemList);

  @override
  Widget build(BuildContext context) {
    bool status = itemList.status;
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
          onChanged: (c) {
            (status) ? status= false : status = true;
            itemList.updateStaus('teste');
          },
          value: status,
          title:  Text(
            "${itemList.name} \t Qt: ${itemList.quantity}", 
            style: TextStyle(
              color: (itemList.priority == "NECESSARIO") ? Colors.blue :  Colors.orange,
            )
          ),
          secondary: CircleAvatar(
            child: Icon(itemList.status ? Icons.check : Icons.error),
          ),
        ),
        onDismissed: (direction){
          ListModel.removeItem2(itemList, 'teste');
      },
    );
  }
}