import 'package:flutter/material.dart';
import 'package:shopping_list/models/user_model.dart';
import 'package:shopping_list/screens/login_screen.dart';
import 'package:shopping_list/tiles/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;

  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.indigo[900],
            Colors.indigo[200],
            Colors.indigo[50],
            Colors.indigo[50],
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomLeft,
        ),
      ),
    );
    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8.0,
                      left: 0.0,
                      child: Text(
                        "Shopping List \n",
                        style: TextStyle(
                            fontSize: 34.0, fontWeight: FontWeight.bold, color: Colors.indigo[50]),
                      ),
                    ),
                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child: ScopedModelDescendant<UserModel>(
                        builder: (context,child,  model){
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(

                                "Olá, ${model.isLoggedIn() ? model.userData['name'] : ''}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.indigo[50]),
                              ),
                              GestureDetector(
                                child: Text(
                                  "${model.isLoggedIn() ? 'Sair' : 'Entre em Contato ou cadastre-se'}",
                                  style: TextStyle(
                                      color: Colors.indigo[50],
                                      fontSize: 16.0),
                                ),
                                onTap: () {
                                  if(!model.isLoggedIn()){
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => LoginScreen()));
                                  }else{
                                    model.signOut();
                                  }
                                },
                              )
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              DrawerTile(Icons.home, "Inicio", pageController, 0),
              DrawerTile(Icons.list, "Lista de Compras", pageController, 1),
              DrawerTile(Icons.network_cell, "Buscar Lista", pageController, 2),
              /*DrawerTile(
                  Icons.playlist_add_check, "Pedidos", pageController, 3),
                  */
            ],
          )
        ],
      ),
    );
  }
}
