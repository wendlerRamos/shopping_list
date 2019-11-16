import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shopping_list/datas/item_data.dart';
import 'package:shopping_list/models/item_model.dart';
import 'package:shopping_list/models/user_model.dart';

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
                  child: ScopedModel<ListModel>(
                    model: ListModel(UserModel()),
                    child: ScopedModelDescendant<ListModel>(
                    rebuildOnChange: true,
                    builder: (context, child, model ){
                      if(model.isLoading && UserModel.of(context).isLoggedIn()){
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }else{
                        return Center(
                          child: Text("Nenhum produto encontrado !", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor), textAlign: TextAlign.center,),
                        );
                      }
                    },
                  ),
                  )
                ),
              ),
            ],
          ),
          )
      ],
    );
  }

  void changedDropDownItem(String selectedItem) {
    //print("Selected city $selectedCity, we are going to refresh the UI");
    setState(() {
      _currentState = selectedItem;
    });
  }

  
}
