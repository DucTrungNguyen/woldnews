import 'package:flutter/material.dart';
import 'package:woldnews/repositories/repositories.dart';
import 'package:rxdart/rxdart.dart';
import 'package:woldnews/models/models.dart';

class NewsBloc{
  final _repository = ApiRepository();
  final _newsFetcher = PublishSubject<NewsModel>();
  final _newSearchFetcher = PublishSubject<NewsModel>();
  final _newsLikeFetch = PublishSubject<NewsModel>();

  Observable<NewsModel> get allNews {
    return _newsFetcher.stream;
  }
  Observable<NewsModel> get searchNews {
    return _newSearchFetcher.stream;
  }
  Observable<NewsModel>  get likeNews {
    return _newsLikeFetch.stream;
  }

  fetchAllNews() async{
    NewsModel newsModel = await _repository.fetchAllNews();
    _newsFetcher.sink.add(newsModel);
  }

  fetchSearchNews() async{
    NewsModel newsModel = await _repository.fetchSearchNews();
    _newSearchFetcher.sink.add(newsModel);
  }

  fetchLikeNews() async{
    NewsModel newsModel = await _repository.fetchFavorite();
    _newsLikeFetch.sink.add(newsModel);
  }

  // add and del From Fire store likes

  addFavorite(val) async => _repository.addFavorite(val);
  delFavorite(val) async => _repository.deleteFavorite(val);

  dispose(){
    _newsFetcher.close();
    _newSearchFetcher.close();
    _newsLikeFetch.close();
  }
}

final newsBloc = NewsBloc();