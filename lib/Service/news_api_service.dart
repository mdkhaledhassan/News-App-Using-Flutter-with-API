import 'dart:convert';

import 'package:news_app/Data/news_class.dart';
import 'package:http/http.dart' as http;

class NewsApiService {
  static Future<List<Articles>> fetchnewsdata(
      {required int page, required String sortBy}) async {
    List<Articles> newslist = [];
    try {
      var link =
          "https://newsapi.org/v2/everything?q=flutter&apiKey=ce03a2d1ffc3478e8a0577805e416300&page=$page&sortBy=$sortBy";
      var response = await http.get(Uri.parse(link));
      var data = jsonDecode(response.body);

      Articles articles;

      for (var i in data['articles']) {
        articles = Articles.fromJson(i);
        newslist.add(articles);
      }
    } catch (e) {
      print(e);
    }
    return newslist;
  }

  static Future<List<Articles>> fetchSearchData({required String query}) async {
    List<Articles> searchList = [];

    try {
      var link =
          "https://newsapi.org/v2/everything?q=$query&apiKey=dee7ee20e389469bb7066a81e61ce95b";
      var response = await http.get(Uri.parse(link));
      print(response.body);
      var data = jsonDecode(response.body);
      Articles articles;
      for (var i in data['articles']) {
        articles = Articles.fromJson(i);
        searchList.add(articles);
      }
    } catch (e) {
      print("the problem is $e");
    }
    return searchList;
  }
}
