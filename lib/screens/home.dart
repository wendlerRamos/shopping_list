import 'package:flutter/material.dart';
import 'search_list_screen.dart';
import 'shopping_list_screen.dart';
import 'new_list_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int bottomSelectedIndex = 1;

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.add_circle),
        title: Text('Nova Lista'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        title: Text('Lista de Compras'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search),
        title: Text('Buscar Lista'),
      ),
    ];
  }

  PageController pageController = PageController(
    initialPage: 1,
    keepPage: true,
  );

  //Used to integrate page view and bottom navigation
  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 300), curve: Curves.ease);
    });
  }

  //Used to integrate bottom navigate click with page view
  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 300), curve: Curves.ease);
    });
  }

  Widget buildPageView() {
    return PageView(
      pageSnapping: true,
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
              )
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
            items: buildBottomNavBarItems(),
          ),
        )
      );
  }
}
/*
  alertNewList(BuildContext context) {
    Widget cancelaButton = FlatButton(
      color: Colors.red,
      child: Text("Cancelar"),
      onPressed:  () {
        Navigator.of(context).pop();
        
      },
    );
    Widget continuaButton = FlatButton(
      color: Color.fromARGB(255, 0, 38, 66),
      child: Text("Criar"),
      onPressed: () async {
        ListModel.createList();
        Future.delayed(Duration(seconds: 4)).then((_){
          setState(() {
            
          });
        });
        Navigator.pop(context);
      },
    );
    //configura o AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("NOVA LISTA", style: TextStyle(color: Color.fromARGB(255, 0, 38, 66)),),
      backgroundColor: Colors.orange[50],
      content: Text("Deseja criar uma nova lista de compras ?"),
      actions: [
        cancelaButton,
        continuaButton,
      ],
    );
    //exibe o diálogo
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  */
