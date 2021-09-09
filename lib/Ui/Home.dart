import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dream_land/Ui/HomeDreamLand.dart';
import 'package:dream_land/Ui/MapGoogel.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[

    HomeDream(),

    MapGoogle(),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

     /* bottomNavigationBar: BottomNavigationBar(

        items: const <BottomNavigationBarItem>[

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.map_rounded),
            label: 'Map',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),*/
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.grey[300],
        backgroundColor: Colors.blue,
        animationCurve: Curves.ease,
        height: 65,
        items: <Widget>[
          Icon(Icons.home, size: 35),

          Icon(Icons.map_outlined, size: 35),

        ],
        onTap: (index) {
          _onItemTapped(index);
        },
      ),

      appBar: AppBar(
        title: Text(
          "Dream Land",
        ),
      ),
      body: Center(
        child: _widgetOptions[_selectedIndex],

      ),


    );
  }
}
