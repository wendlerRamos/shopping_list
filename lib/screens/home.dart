import 'package:flutter/material.dart';

import '../presenter/shoppping_list/screen/new_list_screen.dart';
import '../presenter/shoppping_list/screen/search_list_screen.dart';
import 'shopping_list_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int bottomSelectedIndex = 1;

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      BottomNavigationBarItem(
        icon: Icon(
          Icons.add_circle,
        ),
        label: 'Nova Lista',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
        ),
        label: 'Lista de Compras',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.search,
        ),
        label: 'Buscar Lista',
      ),
    ];
  }

  PageController pageController = PageController(
    initialPage: 1,
    keepPage: false,
  );

  //Used to integrate page view and bottom navigation
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

  //Used to integrate bottom navigate click with page view
  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.jumpToPage(index);
    });
  }

  Widget buildPageView() {
    return PageView(
      physics:NeverScrollableScrollPhysics(),
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
          selectedItemColor: Color.fromARGB(255, 236, 78, 32),
          unselectedItemColor: Color.fromARGB(255, 0, 38, 66),
          items: buildBottomNavBarItems(),
        ),
      ),
    );
  }
}
