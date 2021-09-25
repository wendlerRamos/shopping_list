import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopping_list/application/item/entrypoint/item_controller.dart';
import 'package:shopping_list/application/item/gateway/firebase/domain/ItemDto.dart';
import 'package:shopping_list/domain/item/gateway/input/create_item_input.dart';
import 'package:shopping_list/datas/item_data.dart';
import 'package:shopping_list/datas/list_code_store.dart';
import 'package:shopping_list/domain/item/model/Item.dart';
import 'package:shopping_list/models/list_model.dart';

class FormRegister extends StatefulWidget {
  @override
  _FormRegisterState createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  final itemController = Modular.get<ItemController>();
  String _currentState;
  String _listCode = ListCode().getCurrentList();
  List _option = ["NECESSARIO", "DESEJAVEL"];

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _option) {
      items.add(new DropdownMenuItem(value: city, child: new Text(city)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  final _formKey = GlobalKey<FormState>();
  final _itemFieldController = TextEditingController();
  final _quantityFieldController = TextEditingController(text: "1");
  final _maxValueFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (_currentState == null) {
      _dropDownMenuItems = getDropDownMenuItems();
      _currentState = _dropDownMenuItems[0].value;
    }

    if (_listCode == null) {
      return Row();
    }

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              TextFormField(
                autocorrect: true,
                controller: _itemFieldController,
                decoration: InputDecoration(
                  labelText: "Produto",
                ),
                validator: (value) {
                  if (value.isEmpty)
                    return "Campo obrigatório";
                  else
                    return null;
                },
              ),
              TextFormField(
                controller: _quantityFieldController,
                decoration: InputDecoration(
                  labelText: "Qt",
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value.isEmpty)
                    return "Campo obrigatório";
                  else
                    return null;
                },
                //initialValue: "1",
              ),
              TextFormField(
                controller: _maxValueFieldController,
                decoration: InputDecoration(
                  labelText: "Valor Maximo",
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                //obscureText: true,
              ),
              DropdownButton(
                value: _currentState,
                items: _dropDownMenuItems,
                isExpanded: true,
                hint: Text('Prioridade'),
                //itemHeight: 75,
                onChanged: changedDropDownItem,
              ),
              SizedBox(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    color: Color.fromARGB(255, 236, 78, 32),
                    child: Text("ADICIONAR"),
                    textColor: Colors.white,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        ItemList itemList = ItemList();
                        itemList.name = _itemFieldController.text;
                        itemList.quantity = double.parse(
                            _quantityFieldController.text.replaceAll(new RegExp(r','), '.'));
                        if (_maxValueFieldController.text != "") {
                          itemList.maxValue = double.tryParse(_maxValueFieldController
                              .text
                              .replaceAll(new RegExp(r','), '.'));
                        }

                        itemList.priority = _currentState.toString();
                        final item = ItemDto(itemList.productId, itemList.name, itemList.quantity, itemList.priority, itemList.maxValue, itemList.status);
                         itemController.createItem(item);
                        //ListModel(_listCode).addProductToList(itemList);
                        _quantityFieldController.text = "1";
                        _itemFieldController.text = "";
                        _maxValueFieldController.text = "";
                        final snackBar = SnackBar(
                          content: Text('Inserido com sucesso !'),
                          backgroundColor: Color.fromARGB(255, 0, 38, 66),
                        );
                        Scaffold.of(context).showSnackBar(snackBar);
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  void changedDropDownItem(String selectedItem) {
    setState(() {
      _currentState = selectedItem;
    });
  }
}
