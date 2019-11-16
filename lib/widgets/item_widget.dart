import 'package:flutter/material.dart';
import 'package:shopping_list/datas/item_data.dart';
import 'package:shopping_list/models/item_model.dart';

class ItemWidget extends StatefulWidget {
  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  @override
  Widget build(BuildContext context) {
    return buildItem(context, ItemList);
  }

  Widget buildItem(context, item) {
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
            setState(() {
              
            });
          },
          value: item.productId,
          title:  Text(
            "${item.name} \t Qt: ${item.qt}", 
            style: TextStyle(
              color: (item.priority == "NECESSARY") ? Colors.blue :  Colors.orange,
            )
          ),
          //value: true,
          secondary: CircleAvatar(
            child: Icon(item.status ? Icons.check : Icons.error),
          ),
        ),
      onDismissed: (direction){
          setState(() {

          });
      },
    );
  }
}