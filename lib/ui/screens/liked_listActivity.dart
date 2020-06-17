import 'package:flutter/material.dart';
import 'package:woldnews/blocs/blocs.dart';
import 'package:woldnews/ui/utils/streamBuilder.dart';

ScrollController scrollControllerLikedList;

class LikedListActivity extends StatefulWidget {
  @override
  _LikedListActivityState createState() => _LikedListActivityState();
}

class _LikedListActivityState extends State<LikedListActivity> {

  @override
  void initState() {
    scrollControllerLikedList = ScrollController(initialScrollOffset: 80);
    super.initState();
  }
  @override
  void dispose() {
    scrollControllerLikedList.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    newsBloc.fetchLikeNews();
    return SafeArea(
      child: CustomScrollView(
          controller: scrollControllerLikedList,
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).accentColor,
                        width: 1),
                    borderRadius: BorderRadius.circular(16.0)),
                margin: EdgeInsets.all(6.0),
                padding: EdgeInsets.all(6.0),
                alignment: Alignment.center,
                child: Text(
                  'Your favorite news',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                ),

              ),
            ),


          //streamBuilder
        ],
      ),
    );
  }
}
