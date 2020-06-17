import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:woldnews/ui/screens/searchActivity.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

SearchBarWidget(BuildContext context){
  return SliverPadding(
    padding: EdgeInsets.only(left: 16.0, right: 16.0, top :16),
    sliver: SliverList(
        delegate: SliverChildListDelegate([
          Card(
            color: Colors.transparent,
            elevation: 8,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                color: Theme.of(context).accentColor,
                child: TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.search),
                    border: InputBorder.none,
                    hintText: 'Search here',
                    hintStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.black54
                    )
                  ),
                  textInputAction: TextInputAction.search,
                  cursorColor: Colors.black54,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54
                  ),
                  controller: TextEditingController(),
                  onSubmitted: (textSearch) => search(context, textSearch),
                ),
              ),
            ),
          )
        ])
    )
  );

}

search(BuildContext context, String textSearch){
  Navigator.popUntil(context, (route){
    saveSearch(textSearch);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) =>SearchActivity(
        title: textSearch,
      )
    ));
    return true;
    
  });
}

saveSearch(textSearch) async{
  final SharedPreferences prefs = await _prefs;
  prefs.setString("priorityTheme", textSearch);
}
