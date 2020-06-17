import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woldnews/blocs/blocs.dart';
import 'package:woldnews/ui/utils/streamBuilder.dart';

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
ScrollController scrollControllerSearch;
class SearchActivity extends StatefulWidget {
  final String title;
  SearchActivity({this.title});
  @override
  _SearchActivityState createState() => _SearchActivityState();
}

class _SearchActivityState extends State<SearchActivity> {

  @override
  void initState() {
    scrollControllerSearch = ScrollController()
      ..addListener(() {
        print("offset = ${scrollControllerSearch.offset}");
      });
    super.initState();
  }
  @override
  void dispose() {
    scrollControllerSearch.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    newsBloc.fetchSearchNews();
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: scrollControllerSearch,
          slivers: <Widget>[
            _customAppBar(),
            streamBuilder(newsBloc.searchNews)

          ],
        ),
      ),
    );
  }

  _customAppBar(){
    return SliverList(
        delegate: SliverChildListDelegate([
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon:Icon(Icons.arrow_back),
                onPressed: () =>goBack()
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 48.0),
                  child: Text(
                    "${widget.title}",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              )
            ],
          )
        ]),
    );
  }
  goBack() async{
    final SharedPreferences prefs = await _prefs;
    prefs.setString("priorityTheme", null);
    Navigator.pop(context);
  }

}
