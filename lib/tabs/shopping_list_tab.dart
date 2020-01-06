import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shopping_list/datas/item_data.dart';
import 'package:shopping_list/models/item_model.dart';
import 'package:shopping_list/models/user_model.dart';
import 'package:shopping_list/screens/login_screen.dart';
import 'package:shopping_list/widgets/item_widget.dart';

class ShoppingListTab extends StatefulWidget {
  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingListTab> {
  List _option = ["NECESSARIO", "DESEJAVEL"];
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
    getUser();
    super.initState();
  }

  // here we are creating the list needed for the DropDownButton
  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _option) {
      items.add(new DropdownMenuItem(value: city, child: new Text(city)));
    }
    return items;
  }

  UserModel userModel;
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
                child: Form(
                  key: _formKey,
                  child: Column(
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
                              validator: (value) {
                                if (value.isEmpty) return "Campo obrigatório";
                              },
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
                                if (_formKey.currentState.validate()) {
                                  ItemList itemList = ItemList();
                                  itemList.name = _itemController.text;
                                  itemList.quantity =
                                      double.parse(_qtController.text);
                                  if (_maxValueController.text != "") {
                                    itemList.maxValue =
                                        double.parse(_maxValueController.text);
                                  }
                                  itemList.priority = _currentState.toString();
                                  ListModel(userModel)
                                      .addProductToList(itemList);
                                  
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ))),
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
                      model: ListModel(userModel),
                      child: ScopedModelDescendant<ListModel>(
                        rebuildOnChange: true,
                        builder: (context, child, model) {
                          if (model.isLoading && userModel.isLoggedIn()) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (!userModel.isLoggedIn()) {
                            return Container(
                              padding: EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.remove_shopping_cart,
                                    size: 100.0,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  Text(
                                    "Faça login para adicionar produtos",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColor),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  RaisedButton(
                                    child: Text(
                                      "Entrar",
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                    textColor: Colors.white,
                                    color: Theme.of(context).primaryColor,
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()),
                                      );
                                    },
                                  )
                                ],
                              ),
                            );
                          } else if (model.products == null ||
                              model.products.length == 0) {
                            return Center(
                              child: Text(
                                "Nenhum produto no carrinho",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor),
                                textAlign: TextAlign.center,
                              ),
                            );
                          } else {
                            //print("Itens: ${model.products.length}");
                            return Column(
                                children: model.products.map((product) {
                                  return ItemWidget(product);
                                }).toList(),
                                
                            );
                          }
                        },
                      ),
                    )),
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

  void getUser() {
    this.userModel = UserModel.of(context);
    setState(() {
    });
  }
}
