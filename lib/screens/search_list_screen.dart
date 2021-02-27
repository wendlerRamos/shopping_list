import 'package:flutter/material.dart';
import 'package:shopping_list/datas/list_code_store.dart';
import 'package:shopping_list/widgets/form_search.dart';
import 'package:shopping_list/widgets/list_tile.dart';

class SearchListScreen extends StatefulWidget {
  @override
  _SearchListScreenState createState() => _SearchListScreenState();
}

class _SearchListScreenState extends State<SearchListScreen> {
  @override
  Widget build(BuildContext context) {
    ListCode _listCode = new ListCode();

    List<String> _storedLists = _listCode.getLastShoppingLists();
    return Container(
        //color: Colors.red,
        child: Column(
      children: <Widget>[
        Card(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: 5.0,
              left: 10.0,
              right: 10.0,
              top: 10.0,
            ),
            child: Column(
              children: <Widget>[
                Text(
                  'Buscar Lista',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                    color: Color.fromARGB(255, 0, 38, 66),
                  ),
                  textAlign: TextAlign.center,
                ),
                FormSearchList(),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
          child: Text(
            'Ou escolha uma do seu histórico',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
              color: Color.fromARGB(255, 0, 38, 66),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
            flex: 1,
            child: Card(
                child: (_storedLists.length == 0)
                    ? Center(
                        child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.format_list_bulleted,
                            color: Color.fromARGB(255, 0, 38, 66),
                            size: 50.0,
                          ),
                          Text(
                            'Nenhuma lista no seu histórico',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Color.fromARGB(255, 0, 38, 66),
                            ),
                          ),
                        ],
                      ))
                    : ListView.builder(
                        itemCount: _storedLists.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ShoppingListTile(_storedLists[index], index);
                        },
                      )))
      ],
    ));
  }
}
