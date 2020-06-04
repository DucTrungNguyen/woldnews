import 'package:flutter/material.dart';
import 'package:woldnews/ui/screens/activities.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentItem = 0;
  final _listActivity = [
      NewsListActivity(),
      LikedListActivity(),
      SettingsActivity()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.amber,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chrome_reader_mode),
            title: Text('News')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            title: Text('Favorite')
          ),
          BottomNavigationBarItem(
            icon : Icon(Icons.settings),
            title: Text('Settings')
          )
        ],
        currentIndex: currentItem,
        fixedColor: Theme.of(context).accentColor,
        onTap: _onItemTapped,
      ),
      body: _listActivity[currentItem],

    );

  }
  _onItemTapped(int index){
    setState(() {
      if ( index == currentItem && index == 0){

      };
      if ( index == currentItem && index == 1){

      }
      if (index == currentItem  && index ==2){

      }

      currentItem = index;
    });
  }
}
