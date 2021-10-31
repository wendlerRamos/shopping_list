import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/presenter/core/controller/shopping_list_store.dart';
import 'package:shopping_list/presenter/core/widget/intro_splash_screen.dart';
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
      home: IntroSplashScreen(),
    );
  }
}
