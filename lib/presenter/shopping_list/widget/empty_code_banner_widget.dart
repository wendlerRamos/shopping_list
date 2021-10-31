import 'package:flutter/material.dart';
import 'package:shopping_list/presenter/util/controller/color_manager.dart';

class EmptyCodeBannerWidget extends StatelessWidget {
  const EmptyCodeBannerWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.announcement,
            size: 100.0,
            color: Colors.red,
          ),
          Text(
            "Nenhuma Lista Selecionada",
            textAlign: TextAlign.center,
            style:
                TextStyle(color: ColorManager.getBlueColor(), fontSize: 30.0),
          ),
          Text(
            "Busque uma lista existente ou crie uma nova",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: ColorManager.getBlueColor(),
                fontSize: 15.0,
                fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}
