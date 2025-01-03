import 'package:flutter/material.dart';
import 'package:flutter_apps/layout/home/Newspage.dart';
import 'package:flutter_apps/layout/home/PostNews.dart';
import 'package:flutter_apps/layout/home/apiPage/DetailNewspage.dart';
import 'MyHomePage.dart';
import 'ListViewLearning.dart';
import 'GridViewLearning.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    Newspage(),
    GridViewLearning(),
    ListWithCards(),
    Postnews(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Botttom Navigation Demo'),
      ),
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.cyan,
        unselectedItemColor: Colors.redAccent,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.grid_3x3), label: 'Grid View'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List View'),
          BottomNavigationBarItem(
              icon: Icon(Icons.post_add), label: 'Post Data')
        ],
      ),
    );
  }
}
