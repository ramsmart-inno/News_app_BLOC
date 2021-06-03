import 'dart:convert';
import 'package:newsappbloc/models/article.dart';
import 'package:query_params/query_params.dart';
import 'package:http/http.dart' as http;

class ArticleRepo {
  ArticleData articleData;
  Future<List<Articles>> getArticles(URLQueryParams queryParams) async {
    try {
      http.Response response = await http
          .get('https://newsapi.org/v2/everything?${queryParams.toString()}');
      var list = jsonDecode(response.body);
      List<Articles> articlesList = new List();
      articleData = ArticleData.fromJson(list);
      articlesList.addAll(articleData.articles);
      return articlesList.length == 0 ? null : articlesList;
    } catch (err) {
      return null;
    }
  }
}
