import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
ScrollController scrollControllerSetting;
class SettingsActivity extends StatefulWidget {
  @override
  _SettingsActivityState createState() => _SettingsActivityState();
}

class _SettingsActivityState extends State<SettingsActivity> {
  bool swBrowser = false;
  bool swTheme = false;
  String country = '';
  Color _local = Color(0x000);
  bool initData;
  @override
  void initState() {
    scrollControllerSetting = ScrollController(initialScrollOffset: 84);
    initStateCustom().then((value) => null);
    super.initState();
  }

  @override
  void dispose() {
    scrollControllerSetting.dispose();
    super.dispose();
  }

  Future initStateCustom() async{
    SharedPreferences prefs = await _prefs;
    country = prefs.getString('country');
    swBrowser = prefs.getBool('browser');
    _local = Color(prefs.getInt('color')) ?? 0xFF26A69A;
    initData == true;

    
  }
  
  @override
  Widget build(BuildContext context) {
//    if ( initData == false || initData == null){
//      return SafeArea(
//        child: LinearProgressIndicator(),
//      );
//
//    }
    return SafeArea(
      child:  SingleChildScrollView(
        controller: scrollControllerSetting,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border:Border.all(
                  color: Theme.of(context).accentColor,
                  width: 1
                ),
                borderRadius: BorderRadius.circular(10.0)
              ),
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(6),
              alignment: Alignment.center,
              child: Text(
                'Settings',
                style: TextStyle(fontSize: 24),
              ),


            ),
            ListTile(
              onTap: ()=> changeTheme(!swTheme),
              title: Text('Dark them'),
              subtitle: Text('Enable dark theme'),
              trailing: Switch(
                activeColor: Theme.of(context).accentColor,
                onChanged: (bool value)=> changeTheme(value),
                value: Theme.of(context).brightness == Brightness.dark
                  ? swTheme = true : swTheme = false
              ),
            ),
            Divider(),
            ListTile(
              onTap: ()=>  showCountryArr(),
              title: Text('News of country'),
              subtitle: Text('Country'),

            ),
            Divider(),
            ListTile(
              title: Text('Primary color'),
              subtitle: Text('Color'),
              trailing: Container(
                child: CircleColor(
                  color: _local,
                  circleSize: 50,

                ),

              ),
              onTap: ()=> changePrimaryColor(),
            ),
            Divider(),
            ListTile(
              title: Text('Open in browser'),
              subtitle: Text('To Convenient'),
              onTap: ()=> changeBrowser(!swBrowser),
              trailing: Switch(
                value: swBrowser,
                activeColor: Theme.of(context).accentColor,
                onChanged: (bool value) => changeBrowser(value),
              ),
            )

          ],
        ),

      ),
    );

  }

  void changeTheme(value) async{
      SharedPreferences  prefs = await _prefs;
      DynamicTheme.of(context).setThemeData(ThemeData(
        accentColor: Theme.of(context).accentColor,
        brightness: Theme.of(context).brightness ==  Brightness.dark
          ? Brightness.light : Brightness.dark));

      setState(() {
        swTheme = value;
      });
      await prefs.setString('theme', swTheme ? 'dark' : 'light');
  }

  void showCountryArr() async{
    SharedPreferences prefs = await _prefs;
    String country = prefs.getString('country');
    int selected =0;
    Color textColor = Theme.of(context).brightness == Brightness.dark
      ? Colors.white : Colors.grey[800];
    Color backGround = Theme.of(context).brightness == Brightness.dark
    ? Colors.grey[800] : Colors.white;


  }

  void changePrimaryColor() async{
    SharedPreferences prefs = await _prefs;
    Color local = Color(prefs.getInt('color') ?? 0xFF26A69A);
    showDialog(
      context:context,
      child: SimpleDialog(
        title: Text(
          'Primary color',
          style: TextStyle(fontSize:  24),
        ),
        children: <Widget>[
          MaterialColorPicker(
           selectedColor: local,
           onColorChange: (Color color){
             local = color;
           },
            colors:[
              Colors.red,
              Colors.pink,
              Colors.purple,
              Colors.deepPurple,
              Colors.indigo,
              Colors.blue,
              Colors.lightBlue,
              Colors.cyan,
              Colors.teal,
              Colors.green,
              Colors.lightGreen,
              Colors.lime,
              Colors.yellow,
              Colors.amber,
              Colors.orange,
            ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                onPressed: (){
                  Navigator.pop(context, false);

                },
                child: Text('Cancel'),
              ),
              FlatButton(
                child: Text('OK'),
                onPressed: () async{
                  _local = local;
                  DynamicTheme.of(context).setThemeData(ThemeData(
                    accentColor: local,
                    brightness: Theme.of(context).brightness));
                  await prefs.setInt('color', local.value);
                  Navigator.pop(context, false);
                },
              )
            ],
          )
        ],
      )
    );
  }

  void changeBrowser(value) async{
    SharedPreferences prefs = await _prefs;
    await prefs.setBool('browser', value);
    setState(() {
      swBrowser = value;
    });
  }
}

const PickerCountry = '''
[
    [
        "Russia",
        "US",
        "United Kingdom",
        "Germany",
        "France"
    ]
]
    ''';