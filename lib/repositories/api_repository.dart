import 'package:woldnews/models/models.dart';
import 'repositories.dart';


class ApiRepository{
  final apiClient = new ApiClient();

  //get news
  Future<NewsModel> fetchAllNews() => apiClient.getNewsList();

  //get search news
  Future<NewsModel> fetchSearchNews() => apiClient.getSearchNews();

  // get favorite
  Future<NewsModel> fetchFavorite() => apiClient.getFavoriteNews();

  addFavorite(val) => apiClient.addToFireStore(val);

  deleteFavorite(val) => apiClient.deleteFromFireStore(val);


}