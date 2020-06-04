import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:equatable/equatable.dart';
import 'package:woldnews/ui/bottom_nav_bar.dart';

Future<SharedPreferences> _pres = SharedPreferences.getInstance();
int color;
String theme;
void main() {

  runApp(App());
}



class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Brightness _brightness;


  Future<void> loadSharedReference() async {
    final SharedPreferences prefs = await _pres;
    List<String> _list = [];
    if ( prefs.getBool('firstStart') ==null){
      await prefs.setStringList('liked', _list);
      await prefs.setString('country', 'US');
      await prefs.setBool('firstStart', false);
      await prefs.setInt('color', 0xFF26A69A);
      await prefs.setString('theme', 'light');
      await prefs.setBool('browser', true);


    }else if( prefs.getBool('firstStart') == false){
      color = prefs.getInt('color');
      theme = prefs.getString('theme');

  }
  @override
  void initState()  async{
    // TODO: implement initState
    super.initState();
    loadSharedReference();
  }
  }
  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    if (theme == 'dark'){
      _brightness = Brightness.dark;
    }else _brightness = Brightness.light;
    return DynamicTheme(
      defaultBrightness:  _brightness,
      data: (brightness) =>ThemeData(
        brightness: _brightness,
        accentColor: Color(color ?? 0xFF26A69A)
      ),
      themedWidgetBuilder: (context, theme){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          home: BottomNavBar(),
//          routes: {
//            "/news": (_) => BottomNavBar()
//          },
        );
      },

    );
  }
}

