import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/datas/item_data.dart';
import 'package:shopping_list/widgets/item_widget.dart';

class Teste extends StatefulWidget {
  @override
  _TesteState createState() => _TesteState();
}

class _TesteState extends State<Teste> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text("TESTE")),
      body: StreamBuilder(
        stream: Firestore.instance.collection("users").document('Xh6PBmUsdwdKFkKqDN6S1iy5z8G2').collection("shoppingLists").document("lista").collection('products').snapshots(),
        builder: (context, snapshots){
          switch (snapshots.connectionState){
            case ConnectionState.none:
               return Center(
                  child: Text(
                    "Falha na conexão com o banco de dados",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                    textAlign: TextAlign.center,
                )
              );
              break;
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
              // TODO: Handle this case.
              break;
            case ConnectionState.active:
              if(snapshots.hasData){
                //print(snapshots.data);
                return ListView.builder(
                  itemCount: snapshots.data.documents.length,
                  itemBuilder: (context, i){
                    return ItemWidget(ItemList.fromDocument(snapshots.data.documents[i]));
                  },
                );
              }else{
                return Center(
                  child: Text(
                    "A lista esta vazia",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                    textAlign: TextAlign.center,
                  ),
              );              }
              // TODO: Handle this case.
              break;
            case ConnectionState.done:
              if(snapshots.hasData){
                //print(snapshots.data);
              }else{
                return Text("Não há dados");
              }
              break;
          }
        },
      ),
    );
  }
}