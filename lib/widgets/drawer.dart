import 'package:flutter/material.dart';
import 'package:shopping_list/widgets/alert_find.dart';

@deprecated
class NavigationDrawerWidget extends StatefulWidget {
  @override
  _NavigationDrawerWidgetState createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Drawer(
        elevation: 10.0,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('SHOPPING LIST', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25.0, color: Colors.white),),
                  Padding( padding: EdgeInsets.only(top: 10.0),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    
                    children: <Widget>[
                      Icon(
                        Icons.shopping_cart,
                        size: 50.0,
                        color: Colors.white,
                      )
                    ],
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 236, 78, 32),
              ),
            ),

            ListTile(
              title: Row(
                
                children: <Widget>[
                  Icon(Icons.list, color: Color.fromARGB(255, 0, 38, 66),),
                  SizedBox(width: 10.0,),
                  Text('Lista de Compras', style: TextStyle(color: Color.fromARGB(255, 0, 38, 66)),),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(
              color: Color.fromARGB(255, 236, 78, 32),
              endIndent: 5.0,
              thickness: 1.0,
              height: 2.0,
            ),
            ListTile(
              title: Row(
                
                children: <Widget>[
                  Icon(Icons.search, color: Color.fromARGB(255, 0, 38, 66),),
                  SizedBox(width: 10.0,),
                  Text('Buscar Lista', style: TextStyle(color: Color.fromARGB(255, 0, 38, 66)),),
                ],
              ),
              onTap: () {
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertSeachList();
                    },
                  );
              },
            ),
            Divider(
              color: Color.fromARGB(255, 236, 78, 32),
              endIndent: 5.0,
              thickness: 1.0,
              height: 2.0,
            ),
          ],
        ),
      ),
    );
  }

  
}