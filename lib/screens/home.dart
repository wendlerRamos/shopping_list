import 'package:flutter/material.dart';
import 'package:shopping_list/tabs/new_shopping_list.dart';
import 'package:shopping_list/widgets/custom_drawer.dart';
import 'package:shopping_list/widgets/new_list_button.dart';
import 'package:shopping_list/tabs/home_tab.dart';
import 'package:shopping_list/tabs/shopping_list_tab.dart';


class Home extends StatelessWidget {

  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Text("Shopping List"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          floatingActionButton: NewListButton(),
          body: HomeTab()
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Lista De Compras"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: ShoppingListTab()
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Buscar Lista"),
            centerTitle: true,
          ),
          body: Teste(),
          drawer: CustomDrawer(_pageController),
        ),
      ],
    );
  }
}
