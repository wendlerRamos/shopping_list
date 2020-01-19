import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shopping_list/datas/item_data.dart';
import 'item_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';

class ItemsList extends StatefulWidget {
  @override
  _ItemsListState createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  StreamSubscription connectivitySubscription;
  ConnectivityResult _previousResult;
  
  @override
  void initState() {
    super.initState();
        connectivitySubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult connectivityResult) {
      if (connectivityResult == ConnectivityResult.none) {
        showConnectionState(false);
      }
      else if (_previousResult == ConnectivityResult.none){
        showConnectionState(true);
      }
      _previousResult = connectivityResult;
    });
  }

  

  @override
  void dispose() {
    super.dispose();
    connectivitySubscription.cancel();
  }
  
  @override
  Widget build(BuildContext context) {

    final cardContent =  Expanded(
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
                /*
                Future.delayed(const Duration(milliseconds: 500), () {
                  if(snapshot.connectionState == ConnectionState.none ){
                    showConnectionState(false);
                  }else{
                    showConnectionState(true);
                  }
                });*/
                if (!snapshot.hasData) {
                  return Center(
                      child: CircularProgressIndicator(),
                    );
                }
                else if (snapshot.hasError){
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.error, size: 100.0, color: Colors.red,),
                          Text("Ops... Parece que algo deu errado!", style: TextStyle(color: Color.fromARGB(255, 0, 38, 66), fontSize: 30.0 ),),
                        ],
                      )
                    );
                }else if(snapshot.data.documents.length == 0){
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.not_interested, size: 100.0, color: Color.fromARGB(255, 0, 38, 66),),
                          Text("A lista está vazia!", style: TextStyle(color: Color.fromARGB(255, 0, 38, 66), fontSize: 30.0 ),),
                        ],
                      )
                    );
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
            )
          ),
      )
    );
    return cardContent;
  }

  void showConnectionState(bool isOnline){
    if(isOnline != null){
      if(isOnline){
        final snackBar = SnackBar(content: Text('Online !'), backgroundColor: Colors.green[900],);
        Scaffold.of(context).showSnackBar(snackBar);
      }else{
        final snackBar = SnackBar(content: Text('Você está offline'), backgroundColor: Color.fromARGB(255, 236, 78, 32),);
        Scaffold.of(context).showSnackBar(snackBar);
      }
    }
  }
}
