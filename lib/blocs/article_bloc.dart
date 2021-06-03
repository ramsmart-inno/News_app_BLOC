import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:newsappbloc/constants/constants.dart';
import 'package:newsappbloc/models/article.dart';
import 'package:newsappbloc/repositories/article_repo.dart';
import 'package:query_params/query_params.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleBloc() : super(ArticleInitial());

  List<Articles> articlesList = [];
  int page = 0, limit = 10;
  String query = "covid";
  bool isLoading = false;
  ArticleRepo articleRepo = ArticleRepo();
  @override
  Stream<ArticleState> mapEventToState(
    ArticleEvent event,
  ) async* {
    if (event is FetchArticles) {
      if (!isLoading) {
        isLoading = true;
        try {
          page++;
          URLQueryParams queryParams = URLQueryParams();
          queryParams.append('q', query);
          queryParams.append('page', page);
          queryParams.append('pageSize', limit);
          queryParams.append('apikey', apiKey);
          List<Articles> list = await articleRepo.getArticles(queryParams);
          if (list == null) {
            page--;
            yield ErrorState('Fetch is Failed from NewsApi.Org');
          } else {
            articlesList.addAll(list);
            yield LoadedArticles(articlesList);
          }
        } catch (e) {
          page--;
          yield ErrorState('Failed to fetch Articles from NewsApi.Org');
        }
        isLoading = false;
      }
    }
  }
}
