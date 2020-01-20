import 'package:flutter/material.dart';
import 'package:shopping_list/datas/list_code_store.dart';
import 'package:shopping_list/models/list_model.dart';
import 'package:shopping_list/widgets/drawer.dart';
import 'package:shopping_list/widgets/form_new_item.dart';
import 'package:shopping_list/widgets/items_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _listCode;
  @override
  Widget build(BuildContext context) {
    print('build list');
    _listCode = ListCode().getCurrentList();
    Widget _listCodeCard;
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
    }else{
      _listCodeCard = Row();
    }
    var _scaffoldState = GlobalKey<ScaffoldState>();
    return Scaffold(
        key: _scaffoldState,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Row(
            children: <Widget>[
              Text('Home'),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.topRight,
                  child: FlatButton(
                  onPressed: (){
                    setState(() {
                      
                    });
                  },
                  child: Icon(
                    Icons.refresh,color: Colors.orange[50],
                  ),
              ),
                ),
              )
            ],
          ),
        ),
        drawer: NavigationDrawerWidget(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 236, 78, 32),
          child: Icon(
            Icons.add,
            size: 50.0,
          ),
          onPressed: () {
            alertNewList(context);
          },
        ),
        body: Padding(
          padding:
            EdgeInsets.only(top: 5.0, bottom: 2.0, left: 5.0, right: 5.0),
            child: Column(
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              Card(
                  borderOnForeground: true,
                  child: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: FormRegister(),
                  )
              ),
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



  alertNewList(BuildContext context) {
    Widget cancelaButton = FlatButton(
      color: Colors.red,
      child: Text("Cancelar"),
      onPressed:  () {
        Navigator.of(context).pop();
        
      },
    );
    Widget continuaButton = FlatButton(
      color: Color.fromARGB(255, 0, 38, 66),
      child: Text("Criar"),
      onPressed: () async {
        ListModel.createList();
        Future.delayed(Duration(seconds: 4)).then((_){
          setState(() {
            
          });
        });
        Navigator.pop(context);
      },
    );
    //configura o AlertDialog
    AlertDialog alert = AlertDialog(
      
      title: Text("NOVA LISTA", style: TextStyle(color: Color.fromARGB(255, 0, 38, 66)),),
      backgroundColor: Colors.orange[50],
      content: Text("Deseja criar uma nova lista de compras ?"),
      actions: [
        cancelaButton,
        continuaButton,
        
      ],
    );
    //exibe o diálogo
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
