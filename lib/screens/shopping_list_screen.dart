import 'package:flutter/material.dart';
import 'package:shopping_list/datas/list_code_store.dart';
import 'package:shopping_list/widgets/form_new_item.dart';
import 'package:shopping_list/widgets/items_list.dart';

class ShoppingListScreen extends StatefulWidget {
  @override
  _ShoppingListScreenState createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  String _listCode;
  @override
  Widget build(BuildContext context) {
    _listCode = ListCode().getCurrentList();
    
    //  Setting List code card
    Widget _listCodeCard;
    Widget _formCard;

    if(_listCode != null){
      _listCodeCard = Card(
        borderOnForeground: true,
        child: Padding(
          padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Código da Lista: \t \t', style: TextStyle(fontSize: 20.0),),
            SelectableText(_listCode,  style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic)),
          ],          
        ),
        )
      );

      _formCard = Card(
          borderOnForeground: true,
          child: Padding(
            padding: EdgeInsets.only(
              top: 4.0,
              bottom: 4.0,
              left: 8.0,
              right: 8.0,
            ),
            child: FormRegister(),
          )
      );
    }else{
      _listCodeCard = Row();
      _formCard = Row();
    }

    var _scaffoldState = GlobalKey<ScaffoldState>();
    return Scaffold(
        key: _scaffoldState,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 236, 78, 32),
          child: Icon(
            Icons.refresh,
            size: 30.0,
          ),
          onPressed: () {
            setState(() {
              
            });
          },
        ),
        body: Padding(
          padding:
            EdgeInsets.only(top: 5.0, bottom: 2.0, left: 5.0, right: 5.0),
            child: Column(
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              _formCard,
              _listCodeCard,
              SizedBox(
                height: 1.0,
              ),
              ItemsList()
            ],
          ),
        )
    );
  }
}