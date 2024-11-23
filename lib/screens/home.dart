import 'package:flutter/material.dart';
import 'package:local_crud/pages/list_users.dart';
import 'package:local_crud/pages/profile.dart';

class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _selectedIndex = 0;

  List<Widget> _pages = <Widget>[
    ListUsers(),
    Profile()
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (int index){
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Lista"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil")
        ],
      ),
    );
  }
}