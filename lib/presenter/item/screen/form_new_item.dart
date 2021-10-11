import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopping_list/application/item/entrypoint/item_controller.dart';
import 'package:shopping_list/datas/list_code_store.dart';
import 'package:shopping_list/presenter/item/controller/parse_form_to_item_dto.dart';
import 'package:shopping_list/presenter/util/controller/check_if_field_is_empty.dart';

class FormRegister extends StatefulWidget {
  @override
  _FormRegisterState createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  final itemController = Modular.get<ItemController>();
  final checkIfFieldIsEmpty = Modular.get<CheckIfFieldIsEmpty>();
  final parseFormToItemDto = Modular.get<ParseFormToItemDto>();
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
      child: SingleChildScrollView(
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
                  validator: checkIfFieldIsEmpty.execute,
                ),
                TextFormField(
                  controller: _quantityFieldController,
                  decoration: InputDecoration(
                    labelText: "Quantidade",
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    return checkIfFieldIsEmpty.execute(value);
                  },
                ),
                TextFormField(
                  controller: _maxValueFieldController,
                  decoration: InputDecoration(
                    labelText: "Valor Maximo",
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
                DropdownButton(
                  value: _currentState,
                  items: _dropDownMenuItems,
                  isExpanded: true,
                  hint: Text('Prioridade'),
                  onChanged: changedDropDownItem,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      color: Color.fromARGB(255, 236, 78, 32),
                      child: Text("ADICIONAR"),
                      textColor: Colors.white,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          final item = parseFormToItemDto.execute(_itemFieldController,
                              _quantityFieldController, _maxValueFieldController, _currentState);
                          final result = await itemController.createItem(item);
                          if(result){
                            resetFields();
                            displaySuccessSnackBar();
                          }
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void resetFields(){
    _quantityFieldController.text = "1";
    _itemFieldController.text = "";
    _maxValueFieldController.text = "";
  }

  void displaySuccessSnackBar(){
    final snackBar = SnackBar(
      content: Text('Inserido com sucesso !'),
      backgroundColor: Color.fromARGB(255, 0, 38, 66),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void changedDropDownItem(String selectedItem) {
    setState(() {
      _currentState = selectedItem;
    });
  }
}
