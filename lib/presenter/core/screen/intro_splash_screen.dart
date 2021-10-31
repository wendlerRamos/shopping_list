import 'package:flutter/material.dart';
import 'package:shopping_list/presenter/core/screen/home.dart';
import 'package:shopping_list/presenter/util/controller/color_manager.dart';
import 'package:splashscreen/splashscreen.dart';

class IntroSplashScreen extends StatelessWidget {
  const IntroSplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SplashScreen(
          seconds: 3,
          gradientBackground: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              ColorManager.getBlueColor(),
              Color.fromARGB(255, 0, 10, 25),
            ],
          ),
          navigateAfterSeconds: HomeScreen(),
          loaderColor: Colors.white,
          loadingText: Text(
            'SHOPPING LIST',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Center(
          child: Container(
            width: 150.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("icons/logo-sem-fundo.png"),
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
