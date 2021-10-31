import 'package:flutter/material.dart';
import 'package:shopping_list/presenter/item/screen/form_new_item.dart';

class FormCard extends StatefulWidget {
  const FormCard({Key key}) : super(key: key);

  @override
  _FormCardState createState() => _FormCardState();
}

class _FormCardState extends State<FormCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: true,
      child: Padding(
        padding: EdgeInsets.only(
          top: 4.0,
          bottom: 8.0,
          left: 12.0,
          right: 12.0,
        ),
        child: FormRegister(),
      ),
    );
  }
}
