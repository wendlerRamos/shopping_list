import 'package:flutter/material.dart';
import 'package:shopping_list/datas/item_data.dart';
import 'package:shopping_list/models/list_model.dart';

class FormRegister extends StatefulWidget {
  @override
  _FormRegisterState createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  String _currentState;
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
  final _itemController = TextEditingController();
  final _qtController = TextEditingController(text: "1");
  final _maxValueController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    if(_currentState == null){
      _dropDownMenuItems = getDropDownMenuItems();
      _currentState = _dropDownMenuItems[0].value;
    }
    return Form(
      
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
                    if (value.isEmpty) return "Campo obrigatório"; else return null;
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
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  //initialValue: "1",
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  flex: 4,
                  child: DropdownButton(
                    value: _currentState,
                    items: _dropDownMenuItems,
                    hint: Text('Prioridade'),
                    onChanged: changedDropDownItem,
                  )
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                flex: 4,
                child: TextFormField(
                  controller: _maxValueController,
                  decoration: InputDecoration(
                    labelText: "Valor Maximo",
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  //obscureText: true,
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                flex: 2,
                child: RaisedButton(
                  color: Color.fromARGB(255, 236, 78, 32),
                  child: Text("ADD"),
                  textColor: Colors.white,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      ItemList itemList = ItemList();
                      itemList.name = _itemController.text;
                      itemList.quantity = double.parse(_qtController.text);
                      if (_maxValueController.text != "") {
                        itemList.maxValue =
                            double.tryParse(_maxValueController.text);
                      }
                      itemList.priority = _currentState.toString();
                      ListModel('teste').addProductToList(itemList);
                      _qtController.text = "1";
                      _itemController.text = "";
                      _maxValueController.text = "";
                      final snackBar = SnackBar(content: Text('Inserido com sucesso!'), backgroundColor: Color.fromARGB(255, 0, 38, 66),);
                      Scaffold.of(context).showSnackBar(snackBar);
                    }
                  },
                ),
              ),
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
