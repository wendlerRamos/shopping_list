import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopping_list/application/shopping_list/entrypoint/shopping_list_controller.dart';
import 'package:shopping_list/domain/shopping_list/model/shopping_list.dart';
import 'package:shopping_list/presenter/util/controller/ColorManager.dart';

class NewListScreen extends StatefulWidget {
  @override
  _NewListScreenState createState() => _NewListScreenState();
}

class _NewListScreenState extends State<NewListScreen> {
  final createShoppingList = Modular.get<CreateShoppingListController>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    Widget _continuaButton = FlatButton(
      color: ColorManager.getOrangeColor(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.add_circle, color: Colors.orange[50], size: 20.0),
          SizedBox(width: 10.0),
          Text(
            'Criar Lista',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.orange[50]),
          )
        ],
      ),
      onPressed: () async {
        setState(() {
          _isLoading = true;
        });
        final newList = (await createShoppingList.createShoppingList())
            .getOrElse(() => null);
        (newList != null)
            ? showSuccessSnackBar(newList, context)
            : showFailureSnackBar(context);
        setState(() {
          _isLoading = false;
        });
      },
    );

    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Container(
      child: Card(
        child: Padding(
          padding:
              EdgeInsets.only(bottom: 5.0, left: 10.0, right: 10.0, top: 30.0),
          child: Column(
            children: <Widget>[
              Text(
                'Criar Lista',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  color: ColorManager.getBlueColor(),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.0),
              Text(
                  'Cria uma nova lista com um código aleatório, que é usado para acessá-la'),
              SizedBox(height: 10.0),
              _continuaButton
            ],
          ),
        ),
      ),
    );
  }

  void showSuccessSnackBar(ShoppingList newList, BuildContext context) {
    final snackBar = SnackBar(
      content: Text(
        'Lista criada com sucesso !\n Código ${newList.code}',
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.green[900],
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void showFailureSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text(
        'Houve uma falha na criação da lista, tente novamente mais tarde !',
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.red[900],
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
