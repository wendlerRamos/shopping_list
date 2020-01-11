import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shopping_list/models/list_model.dart';

import 'item_widget.dart';

class ItemsList extends StatefulWidget {
  @override
  _ItemsListState createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 5.0, left: 4.0, right: 4.0),
        scrollDirection: Axis.vertical,
        children: <Widget>[
          SizedBox(
            height: 2.0,
          ),
          Card(
            margin: EdgeInsets.all(4.0),
            child: Padding(
                padding: EdgeInsets.all(4.0),
                child: ScopedModel<ListModel>(
                  model: ListModel('teste'),
                  child: ScopedModelDescendant<ListModel>(
                    rebuildOnChange: true,
                    builder: (context, child, model) {
                      if (model.isLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }else if (model.products == null || model.products.length == 0) {
                        return Center(
                          child: Text(
                            "Nenhum produto na lista !",
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor),
                            textAlign: TextAlign.center,
                          ),
                        );
                      } else {
                        //print("Itens: ${model.products.length}");
                        return Column(
                          children: model.products.map((product) {
                            return ItemWidget(product);
                          }).toList(),
                        );
                      }
                    },
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
