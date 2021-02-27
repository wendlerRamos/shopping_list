import 'package:flutter/material.dart';
import 'package:shopping_list/datas/list_code_store.dart';
import 'package:shopping_list/screens/home.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(Main());

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    ListCode _listCode = ListCode();
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
            Color.fromARGB(255, 0, 38, 66),
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
