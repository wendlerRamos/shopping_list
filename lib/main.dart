import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopping_list/app_module.dart';
import 'package:shopping_list/datas/list_code_store.dart';
import 'package:shopping_list/screens/home.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(ModularApp(
      module: AppModule(),
    ));
