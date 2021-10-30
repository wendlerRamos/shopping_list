import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/presenter/core/controller/shopping_list_store.dart';
import 'package:shopping_list/presenter/util/controller/ColorManager.dart';
import 'package:shopping_list/presenter/core/screen/home.dart';
import 'package:splashscreen/splashscreen.dart';

class AppWidget extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    ShoppingListStore();
    return MaterialApp(
      title: 'Shopping List',
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      debugShowCheckedModeBanner: true,
      home: _introScreen(),
    );
  }
}

Widget _introScreen() {
  return Stack(
    children: <Widget>[
      SplashScreen(
        seconds: 5,
        gradientBackground: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            ColorManager.getBlueColor(),
            Color.fromARGB(255, 0, 10, 25),
          ],
        ),
        navigateAfterSeconds: HomeScreen(),
        loaderColor: Colors.transparent,
      ),
      Center(
        child: Container(
          width: 150.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("icons/logo-app-sem-fundo.png"),
              fit: BoxFit.none,
            ),
          ),
        ),
      ),
    ],
  );
}