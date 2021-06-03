part of 'article_bloc.dart';

@immutable
abstract class ArticleState {}

class ArticleInitial extends ArticleState {}

class LoadedArticles extends ArticleState {
  final List<Articles> articlesList;

  LoadedArticles(this.articlesList);
  List<Object> get props => [this.articlesList];
}

class ErrorState extends ArticleState {
  final String errorMessage;

  ErrorState(this.errorMessage);

  List<Object> get props => [this.errorMessage];
}
