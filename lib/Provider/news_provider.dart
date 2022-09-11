import 'package:flutter/cupertino.dart';
import 'package:news_app/Data/news_class.dart';
import 'package:news_app/Service/news_api_service.dart';
import 'package:provider/provider.dart';

class NewsProvider with ChangeNotifier {
  List<Articles> newslist = [];
  List<Articles> searchList = [];

  Future<List<Articles>> getNewsData(
      {required int page, required String sortBy}) async {
    newslist = await NewsApiService.fetchnewsdata(page: page, sortBy: sortBy);
    return newslist;
  }

  Articles findByDate({String? date}) {
    Articles data =
        newslist.firstWhere((element) => element.publishedAt == date);
    return data;
  }

  Future<List<Articles>> getSearchData({required String query}) async {
    searchList = await NewsApiService.fetchSearchData(query: query);
    notifyListeners();
    return searchList;
  }
}
