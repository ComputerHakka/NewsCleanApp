import 'package:news_flutter_app/core/resources/data_state.dart';
import 'package:news_flutter_app/features/daily_news/domain/entities/article.dart';

abstract class ArticleRepository {
  Future<DataState<List<ArticleEntity>>> getNewsArticles();
}
