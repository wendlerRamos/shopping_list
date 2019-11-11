import 'package:flutter/material.dart';
import 'package:shopping_list/tiles/form_add_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShoppingListTab extends StatefulWidget {
  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingListTab> {
  List _option = ["NECESSÁRIO", "DESEJÁVEL"];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentState;

  @override
  void initState() {
    Firestore.instance
        .collection("teste")
        .document("teste")
        .setData({"teste": "teste"});
    _dropDownMenuItems = getDropDownMenuItems();
    _currentState = _dropDownMenuItems[0].value;
    super.initState();
  }

  // here we are creating the list needed for the DropDownButton
  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _option) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(new DropdownMenuItem(value: city, child: new Text(city)));
    }
    return items;
  }

  final _formKey = GlobalKey<FormState>();
  //final _scafoldKey = GlobalKey<ScaffoldState>();

  final _itemController = TextEditingController();
  final _qtController = TextEditingController(text: "1");
  final _priorityController = TextEditingController();
  final _maxValueController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
            margin: EdgeInsets.all(4.0),
            borderOnForeground: true,
            child: Padding(
              
              padding: EdgeInsets.all(10.0),
              child: Form( key: _formKey, child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            autocorrect: true,
                            controller: _itemController,
                            decoration: InputDecoration(
                              labelText: "Produto",
                            ),
                            validator: (value){ if(value.isEmpty) return "Campo obrigatório";},
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            controller: _qtController,
                            decoration: InputDecoration(
                              labelText: "Qt",
                            ),
                            keyboardType: TextInputType.numberWithOptions(
                                decimal: true),
                            //initialValue: "1",
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                            flex: 2,
                            child: DropdownButton(
                              value: _currentState,
                              items: _dropDownMenuItems,
                              hint: Text('Prioridade'),
                              onChanged: changedDropDownItem,
                            )),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            controller: _maxValueController,
                            decoration: InputDecoration(
                              labelText: "Valor Maximo",
                            ),
                            keyboardType: TextInputType.numberWithOptions(
                                decimal: true),
                            //obscureText: true,
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          flex: 1,
                          child: RaisedButton(
                            color: Colors.indigo[900],
                            child: Text("ADD"),
                            textColor: Colors.white,
                            onPressed: () {
                              if(_formKey.currentState.validate()){
                                print('astra') ;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            )
          ),
          Expanded(
            child: ListView(
            padding: EdgeInsets.only(top: 5.0, left: 4.0, right: 4.0),
            children: <Widget>[
              SizedBox(
                height: 2.0,
              ),
              Card(
                margin: EdgeInsets.all(4.0),
                child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Column(children: _createItens()),
                ),
              ),
            ],
          ),
          )
      ],
    );
  }

  void changedDropDownItem(String selectedCity) {
    //print("Selected city $selectedCity, we are going to refresh the UI");
    setState(() {
      _currentState = selectedCity;
    });
  }

  List<Widget> _createItens() {
    List<Widget> widgets = [];
    for (int i = 0; i < 100; i++) {
      /*
      widgets.add(Row(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Text("Descricao"),
          ),
          Expanded(flex: 1, child: Text("XX")),
          Expanded(flex: 2, child: Text("XXX,XX")),
          Expanded(
            flex: 1,
            child: Icon(Icons.restore_from_trash),
          ),
        ],
      ));
      */
      widgets.add(buildItem(context, i));
    }
    return widgets;
  }

    Widget buildItem(context, index) {
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
          title: Text("TESTE $index"),
          value: true,
          secondary: CircleAvatar(
            child: Icon(true ? Icons.check : Icons.error),
          ),
        ),
      onDismissed: (direction){
          setState(() {
            /*
            _lastRemoved = Map.from(_toDoList[index]);
            _lastRemovedPos = index;
            _toDoList.removeAt(index);
            _saveData();

            final snack = SnackBar(
              content: Text('Tarefa ${_lastRemoved['title']} removida !'),
              action: SnackBarAction(
                  label: "Desfazer",
                  onPressed: (){
                    setState(() {
                      _toDoList.insert(_lastRemovedPos, _lastRemoved);
                      _saveData();
                    });
                  }
              ),
              duration: Duration(seconds: 10),
            );
            Scaffold.of(context).removeCurrentSnackBar(); 
            Scaffold.of(context).showSnackBar(snack);
            */
          });
      },
    );
  }
}
