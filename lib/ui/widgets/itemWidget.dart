import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:woldnews/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woldnews/ui/screens/activities.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();


buildListSliver(NewsModel values, BuildContext context) {
  if (values.articles.length == 0) {
    return SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Center(
              child: Text('You didn\'t like anything',
                  style: TextStyle(
                      color: Theme.of(context).accentColor, fontSize: 24))),
        ));
  } else {
    //final delegate = SliverChildBuilderDelegate;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
              (BuildContext context,int  index) => ListItemWidget( values.articles[index]),
          childCount: values.articles.length),
    );
  }
}



class ListItemWidget extends StatefulWidget {

  final Articles models;
  ListItemWidget(this.models);

  @override
  _ListItemWidgetState createState() => _ListItemWidgetState();
}

class _ListItemWidgetState extends State<ListItemWidget> with TickerProviderStateMixin {
  // animation
  Animation colorAnimation;
  AnimationController colorAnimationController;

  // List
  List<String> _listLiked = [];

  SharedPreferences prefs;

  IconData icons  = Icons.favorite_border;

  double height = 100;
  int maxLine  = 2;

  initSharedPrefs() async{
    prefs = await _prefs;

    _listLiked = prefs.get("liked");
    if (_listLiked.indexOf(widget.models.url) >0){
      icons = Icons.favorite;
    }
//    else{
//      icons = Icons.favorite_border;
//    }

  }

  initHeight(){
    if (widget.models.title.length > 90){
      height += 20;
      maxLine++;

    }
    if (widget.models.title.length > 110){
      height +=25;
      maxLine += 2;
    }
  }
  initState() {
    initSharedPrefs();
    initHeight();
    colorAnimationController = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this);
    colorAnimation = Tween(begin: 1.0, end: .5).animate(colorAnimationController);
    super.initState();
  }
  @override
  void dispose() {
    colorAnimationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: colorAnimationController,
      builder: (context, _){
        return _buildItem(context);

      },
    );
  }

  _buildItem(context){

    String urlImage = widget.models.urlImage;
    print("Link anh $urlImage");

//    image
//        .resolve(ImageConfiguration())
//        .addListener((imageInfo, synchronousCall) {
//      colorAnimationController.forward();
//
//    });
    var image;
    if (urlImage == null)
      image = Image.network('https://i.picsum.photos/id/1002/4312/2868.jpg?hmac=5LlLE-NY9oMnmIQp7ms6IfdvSUQOzP_O3DPMWmyNxwo').image;
    else
      image = Image.network(urlImage).image;

    return Container(
      height: height,
      child: InkWell(
        onTap:()=> _viewWeb(widget.models, context),
        child: Card(
          color: Colors.black54,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                image: DecorationImage(
//                  colorFilter: ColorFilter.mode(
//                      Colors.black12.withOpacity(colorAnimation.value),
//                      BlendMode.color),
                  fit: BoxFit.cover,
                  image: image
                )
              ),
              child: _content(),
            ),
          ),
        ),
      ),
    );
  }


  _content(){
    return Column(
      children: <Widget>[
        _headerItem(),
        _contentItem(),
//        _dateItem()
      ],
    );

  }

  _headerItem(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          widget.models.source.name,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
        _dateItem(),
        Container(
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.share,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: ()=>Share.share(widget.models.url),
              ),
              IconButton(
                icon: Icon(
                  icons,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: ()=> {},
              )
            ],
          ),
        )
      ],
    );

  }
  _contentItem(){
    return Flexible(
      child: Text(
        widget.models.title,
        maxLines: maxLine,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }
  _dateItem(){
    DateFormat format = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
    final unformDate = format.parse(widget.models.publishedAt);
    Duration difference = unformDate.difference(DateTime.now());
    return Container(

      child: Text(
        (int.tryParse(difference.inHours.abs().toString()) < 12)
            ? difference.inHours.abs().toString() + " hours ago"
            : difference.inDays.abs().toString() + " days ago",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      alignment: Alignment.centerLeft,
    );
  }

  _viewWeb(Articles articles, context) async{
    String url = articles.url;
    SharedPreferences preferences = await _prefs;

    if ( !preferences.getBool("browser")){
      _launchURL(url, false);


    }else{
      _launchURL(url, true);



    }

  }

//  _openWebsite(Articles articles, context){
//    Navigator.push(context, MaterialPageRoute(
//      builder: (context)=> {}
//    ));
//  }
  _launchURL(url, inBrowsers) async {
//    const url = 'https://flutter.dev';

    if ( inBrowsers){
      if (await canLaunch(url)) {
        await launch(
            url
        );
      } else {
        throw 'Could not launch $url';
      }
    }else{
      if (await canLaunch(url)) {
        await launch(
            url,
            forceSafariVC: true,
            forceWebView: true
        );
      } else {
        throw 'Could not launch $url';
      }

    }

  }
}

