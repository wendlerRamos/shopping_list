import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomBarItems{
  static List<BottomNavigationBarItem> getItems() {
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
}
