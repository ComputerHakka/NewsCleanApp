part of 'remote_article_bloc.dart';

sealed class RemoteArticleState extends Equatable {
  final List<ArticleEntity>? articles;
  final DioException? exception;
  const RemoteArticleState({this.articles, this.exception});

  @override
  List<Object> get props => [articles!, exception!];
}

final class RemoteArticlesLoading extends RemoteArticleState {
  const RemoteArticlesLoading();
}

final class RemoteArticlesDone extends RemoteArticleState {
  const RemoteArticlesDone(List<ArticleEntity> article)
      : super(articles: article);
}

final class RemoteArticlesException extends RemoteArticleState {
  const RemoteArticlesException(DioException exception)
      : super(exception: exception);
}
