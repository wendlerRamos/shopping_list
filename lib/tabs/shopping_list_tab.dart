import 'package:flutter/material.dart';
import 'package:shopping_list/tiles/form_add_tile.dart';

class ShoppingListTab extends StatefulWidget {
  @override
  _ShoppingListState createState() => _ShoppingListState();

}

class _ShoppingListState extends State<ShoppingListTab> {
  List _option =
  ["NECESSÁRIO", "DESEJÁVEL"];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentState;

  @override
  void initState() {
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
      items.add(new DropdownMenuItem(
          value: city,
          child: new Text(city)
      ));
    }
    return items;
  }


  final _formKey = GlobalKey<FormState>();
  //final _scafoldKey = GlobalKey<ScaffoldState>();


  final _itemController = TextEditingController();
  final _qtController = TextEditingController();
  final _priorityController = TextEditingController();
  final _maxValueController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only( top: 5.0, left: 4.0, right: 4.0),
      children: <Widget>[
        Column(
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(4.0),
              borderOnForeground: true,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child:   TextField(
                            autocorrect: true,
                            controller: _itemController,
                            decoration: InputDecoration(
                              labelText: "Produto",
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0,),
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
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: DropdownButton(
                            value: _currentState,
                            items: _dropDownMenuItems,
                            hint: Text('Prioridade'),
                            onChanged: changedDropDownItem,


                          )
                        ),
                        SizedBox(width: 10.0,),
                        Expanded(
                          flex: 1,
                          child:  TextField(
                            controller: _maxValueController,
                            decoration: InputDecoration(
                              labelText: "Valor Maximo",
                            ),
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            //obscureText: true,
                          ),
                        ),
                        SizedBox(width: 20.0,),
                        Expanded(
                          flex: 1,
                          child: RaisedButton(
                            color: Colors.indigo[900],
                            child: Text("ADD"),
                            textColor: Colors.white,
                            onPressed: (){},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ),
            SizedBox(
              height: 16.0,
            ),
          ],
        ),
        SizedBox(height: 10.0,),
        Card(
          margin: EdgeInsets.all(4.0),
          child: Padding(
            padding: EdgeInsets.all(4.0),
            child: Column(
              children: _createItens()
            ),
          ),
        ),
      ],
    );
  }

  void changedDropDownItem(String selectedCity) {
    //print("Selected city $selectedCity, we are going to refresh the UI");
    setState(() {
      _currentState = selectedCity;
    });
  }

  List<Widget> _createItens(){
    List<Widget> widgets = [];
    for(int i = 0; i<100; i++){
      widgets.add(Row(

        children: <Widget>[
          Expanded(flex: 5, child: Text("Descricao"),),
          Expanded(flex: 1, child: Text("XX")),
          Expanded(flex: 2, child: Text("XXX,XX")),
          Expanded(flex: 1, child: Icon(Icons.restore_from_trash),),
        ],
      ));
    }
    return widgets;
  }
}
