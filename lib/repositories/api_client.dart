import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:woldnews/models/models.dart';
import 'package:dio/dio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ApiClient{
  static const baseUrl = 'https://newsapi.org/v2';
  Dio  _dio;
  String _country = 'us';
  final _prefs = SharedPreferences.getInstance();
  final _apiKey = 'b6d704c5b1d94394a237ab86dbaad8ca';
  ApiClient(){
    BaseOptions options = BaseOptions(
      receiveTimeout: 10000,
      connectTimeout: 10000,
      baseUrl: baseUrl
    );
    _dio = Dio(options);
  }


  Future<NewsModel> getNewsList() async{
    final SharedPreferences pref =  await _prefs;
    String country = pref.getString('country');

    if (country == 'Russia'){
      _country = 'ru';
    }else if ( country == 'US'){
      _country = 'us';
    }else if (country == 'Germany'){
      _country = 'de';
    }else if ( country ==  'United Kingdom'){
      _country = 'gb';
    }else if ( country ==  'France')
      // ignore: unnecessary_statements
      _country == 'fr';


    String url = "$baseUrl/top-headlines?country=$_country&apiKey=$_apiKey";

    try{
      final response = await _dio.get(url);
      return NewsModel.fromJson(response.data);

    }on DioError catch(e){
    }


  }

  Future<NewsModel> getSearchNews() async{
    final SharedPreferences prefs = await _prefs;
    String priorityTheme = prefs.getString("priorityTheme");
    String url =  "https://newsapi.org/v2/everything?q=$priorityTheme&apiKey=$_apiKey";
    
    try{
      final response = await _dio.get(url);
      return NewsModel.fromJson(response.data);
    } on DioError catch(ex){
      
    }

  }

  Future<NewsModel> getFavoriteNews() async{
      final NewsModel  newsModel = new NewsModel();
      List<Articles> listAr = List<Articles>();
      var articles = await Firestore.instance
        .collection("users")
        .document(await getMyID())
        .get();
      if ( articles.data != null){
        for ( int i = 0; i < articles.data.length; i++){
            listAr.add(Articles.fromJson(articles.data.values.toList()[i]));
        }
      }

      newsModel.articles = listAr;
      return newsModel;

  }

  getMyID() async {
    String id = ( await _prefs).getString('id');
    return id ?? generateID();
  }

  generateID() async{
    final id = Uuid().v4();
    ( await _prefs).setString('id', id);
  }

  addToFireStore(val) async{
      final String key = val['url'].toString().replaceAll('/', '').replaceAll('.', '');
      Firestore.instance
        .collection('users')
        .document(await getMyID())
        .setData({key : val}, merge: true);
  }

  deleteFromFireStore(val) async{
    final String key = val['url'].toString().replaceAll('/', '').replaceAll('.', '');
    Firestore.instance
      .collection('users')
      .document(await getMyID())
      .updateData({key : FieldValue.delete()});

  }





}