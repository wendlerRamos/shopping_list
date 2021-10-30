import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/presenter/core/shopping_list_store.dart';
import 'package:shopping_list/presenter/item/screen/form_new_item.dart';
import 'package:shopping_list/widgets/items_list.dart';

class ShoppingListScreen extends StatefulWidget {
  @override
  _ShoppingListScreenState createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  String _listCode;
  StreamSubscription connectivitySubscription;
  ConnectivityResult _previousResult;
  Color connectionColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) {
      if (connectivityResult == ConnectivityResult.none) {
        connectionColor = Colors.yellow[900];
      } else {
        connectionColor = Colors.green[900];
      }
      if(_previousResult != connectivityResult){
        setState(() {

        });
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
    _listCode = ShoppingListStore().getCurrentList();
    Widget _formCard;

    if (_listCode != null) {
      _formCard = Card(
        borderOnForeground: true,
        child: Padding(
          padding: EdgeInsets.only(
            top: 4.0,
            bottom: 8.0,
            left: 12.0,
            right: 12.0,
          ),
          child: FormRegister(),
        ),
      );
    } else {
      _formCard = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.announcement,
              size: 100.0,
              color: Colors.red,
            ),
            Text(
              "Nenhuma Lista Selecionada",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 38, 66),
                  fontSize: 30.0),
            ),
            Text(
              "Busque uma lista existente ou crie uma nova",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 38, 66),
                  fontSize: 15.0,
                  fontStyle: FontStyle.italic),
            ),
          ],
        ),
      );
    }
    var _scaffoldState = GlobalKey<ScaffoldState>();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldState,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Código da Lista: ',
                      style: TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.normal),
                    ),
                    SelectableText(
                      _listCode??"",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      setConnectionText(),
                      style: TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.normal),
                    ),
                    Icon(
                      Icons.circle,
                      color: connectionColor,
                    )
                  ],
                )
                //SizedBox(width: 30.0,),
              ],
            ),
          ),
          bottom: TabBar(
            indicatorColor: Colors.deepOrange,
            labelColor: Colors.deepOrange,
            unselectedLabelColor: Colors.black,
            tabs: [
              Tab(
                text: "Ver Lista",
              ),
              Tab(
                text: "Adicionar Item",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(top: 0.0, bottom: 2.0, left: 5.0, right: 5.0),
              child: Column(
                verticalDirection: VerticalDirection.down,
                children: <Widget>[
                  SizedBox(
                    height: 1.0,
                  ),
                  ItemsList()
                ],
              ),
            ),
            _formCard,
          ],
        ),
      ),
    );
  }

  String setConnectionText(){
    switch(_previousResult){
      case(ConnectivityResult.none):
        return "Offline";
      default:
        return "Online";
    }
  }
}
