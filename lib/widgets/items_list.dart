import 'package:flutter/material.dart';
import 'package:shopping_list/datas/item_data.dart';
import 'item_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemsList extends StatefulWidget {
  @override
  _ItemsListState createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Card(
      margin: EdgeInsets.all(4.0),
      child: Padding(
          padding: EdgeInsets.all(4.0),
          child: StreamBuilder(
            stream: Firestore.instance
                .collection('shoppingLists')
                .document('teste')
                .collection('products')
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Text("Loading..");
              }
              else if (snapshot.hasError){
                  return Text("Ops... Something went wrong !");
              }else if(snapshot.data.documents.length == 0){
                  return Text("This list it's empty !");

              }
              return ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: snapshot.data.documents.map((DocumentSnapshot document){
                  ItemList _itemList = ItemList.fromDocument(document);
                  //print(_itemList);
                  return ItemWidget(
                    itemList: _itemList,
                  );
                }).toList(),
              );
            },
          )),
    ));
  }
}
