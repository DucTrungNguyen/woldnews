import 'package:flutter/material.dart';
import 'package:woldnews/blocs/blocs.dart';
import 'package:woldnews/ui/widgets/searchBarWidget.dart';
import 'package:woldnews/ui/utils/streamBuilder.dart';


ScrollController scrollController;
class NewsListActivity extends StatefulWidget {
  @override
  _NewsListActivityState createState() => _NewsListActivityState();
}

class _NewsListActivityState extends State<NewsListActivity> {

  @override
  void initState() {

    scrollController = ScrollController(initialScrollOffset: 80);
    super.initState();
  }
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    newsBloc.fetchAllNews();
    return SafeArea(
      child: CustomScrollView(
        controller: scrollController,
        slivers: <Widget>[
          SearchBarWidget(context),
          streamBuilder(newsBloc.allNews)
      
        ],
      ),
    );
  }
}
