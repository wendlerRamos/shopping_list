import 'package:flutter/material.dart';
import 'package:shopping_list/presenter/core/widget/bottom_bar_items.dart';
import 'package:shopping_list/presenter/util/controller/ColorManager.dart';

import '../../shopping_list/screen/new_list_screen.dart';
import '../../shopping_list/screen/search_list_screen.dart';
import '../../shopping_list/screen/shopping_list_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int bottomSelectedIndex = 1;

  PageController pageController = PageController(
    initialPage: 1,
    keepPage: false,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Text('Shopping List'),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.orange[50],
                ),
              ),
            ),
          ],
        ),
      ),
      body: buildPageView(),
      bottomNavigationBar: Card(
        child: BottomNavigationBar(
          currentIndex: bottomSelectedIndex,
          onTap: (index) {
            bottomTapped(index);
          },
          selectedItemColor: ColorManager.getOrangeColor(),
          unselectedItemColor: ColorManager.getBlueColor(),
          items: BottomBarItems.getItems(),
        ),
      ),
    );
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.jumpToPage(index);
    });
  }

  Widget buildPageView() {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        NewListScreen(),
        ShoppingListScreen(),
        SearchListScreen(),
      ],
    );
  }

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(
        index,
        duration: Duration(
          milliseconds: 300,
        ),
        curve: Curves.easeInOutCubic,
      );
    });
  }
}
