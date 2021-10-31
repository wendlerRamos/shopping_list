import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/presenter/util/controller/ColorManager.dart';

class ShoppingListScreenHeader extends StatefulWidget {
  final String listCode;

  const ShoppingListScreenHeader({Key key, this.listCode}) : super(key: key);

  @override
  _ShoppingListScreenHeaderState createState() =>
      _ShoppingListScreenHeaderState();
}

class _ShoppingListScreenHeaderState extends State<ShoppingListScreenHeader> {
  ConnectivityResult currentConnection;

  @override
  void initState() {
    super.initState();
    Connectivity().checkConnectivity().then((value) {
      setState(() {
        currentConnection = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'Código da Lista: ',
                style: TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.normal),
              ),
              SelectableText(
                widget.listCode ?? "",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          StreamBuilder(
              initialData: currentConnection,
              stream: Connectivity().onConnectivityChanged,
              builder: (context, AsyncSnapshot<ConnectivityResult> connection) {
                if (connection.hasData) {
                  currentConnection = connection.data;
                }
                return buildConnectionIndicatorWidget();
              }),
        ],
      ),
    );
  }

  Row buildConnectionIndicatorWidget() {
    return Row(
      children: [
        Text(
          setConnectionText(),
          style: TextStyle(
            color: Colors.grey,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.normal,
          ),
        ),
        SizedBox(
          width: 5.0,
        ),
        Icon(
          Icons.circle,
          color: getConnectionStateColor(),
        )
      ],
    );
  }

  SizedBox buildLoadingConnectionWidget() {
    return SizedBox(
      height: 20.0,
      child: CircularProgressIndicator(
        valueColor:
            AlwaysStoppedAnimation<Color>(ColorManager.getOrangeColor()),
      ),
      width: 20.0,
    );
  }

  Color getConnectionStateColor() =>
      (currentConnection == ConnectivityResult.none)
          ? Colors.yellow[900]
          : Colors.green[900];

  String setConnectionText() {
    switch (currentConnection) {
      case (ConnectivityResult.none):
        return "Offline";
      default:
        return "Online";
    }
  }
}
