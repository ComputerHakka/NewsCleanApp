part of 'local_article_bloc.dart';

sealed class LocalArticleState extends Equatable {
  final List<ArticleEntity>? articles;
  const LocalArticleState({this.articles});

  @override
  List<Object> get props => [articles!];
}

final class LocalArticleLoading extends LocalArticleState {
  const LocalArticleLoading();
}

final class LocalArticleDone extends LocalArticleState {
  const LocalArticleDone({super.articles});
}
