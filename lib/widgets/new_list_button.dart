import 'package:flutter/material.dart';
//import 'package:loja_app/screens/cart_screen.dart';

class NewListButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      child: Icon(Icons.shopping_cart, color: Colors.indigo[50]),
      onPressed: (){

        /*
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CartScreen())
        );
        */
      },
    );
  }
}
