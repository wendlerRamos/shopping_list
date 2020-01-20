import 'package:flutter/material.dart';
import 'package:shopping_list/datas/item_data.dart';
import 'package:shopping_list/datas/list_code_store.dart';
import 'package:shopping_list/models/list_model.dart';

class ItemWidget extends StatefulWidget {
  final ItemList itemList;
  const ItemWidget ({Key key, @required this.itemList}) : super(key:key);
  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  String _listCode = ListCode().getCurrentList();
  
  @override
  Widget build(BuildContext context) {
    bool status = widget.itemList.status;
    String _subtitleText = "Qt: " + widget.itemList.quantity.toString();
    if(widget.itemList.maxValue != null){
      _subtitleText+= "\t Valor Máx: " + widget.itemList.maxValue.toString();
    }
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
          activeColor: (widget.itemList.priority == "NECESSARIO") ? Color.fromARGB(255, 0, 38, 66) :  Color.fromARGB(255, 236, 78, 32),
          checkColor: Colors.white,
          onChanged: (c) {
            (status) ? status= false : status = true;
            widget.itemList.updateStaus(_listCode);
          },
          value: status,
          title:  Text(
            "${widget.itemList.name}", 
            style: TextStyle(
              color: (widget.itemList.priority == "NECESSARIO") ? Color.fromARGB(255, 0, 38, 66) :  Color.fromARGB(255, 236, 78, 32),
            )
          ),
          subtitle: Text(_subtitleText,),
          secondary: CircleAvatar(
            backgroundColor: (widget.itemList.priority == "NECESSARIO") ? Color.fromARGB(255, 0, 38, 66) :  Color.fromARGB(255, 236, 78, 32),
            child: Icon(widget.itemList.status ? Icons.check : Icons.add_shopping_cart, color: Colors.white,),
          ),
        ),
        onDismissed: (direction){
          ListModel.removeItem2(widget.itemList, _listCode);
      },
    );
  }
}