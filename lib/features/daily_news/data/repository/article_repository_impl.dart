import 'dart:io';

import 'package:dio/dio.dart';
import 'package:news_flutter_app/core/constants/constants.dart';
import 'package:news_flutter_app/core/resources/data_state.dart';
import 'package:news_flutter_app/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:news_flutter_app/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:news_flutter_app/features/daily_news/data/models/article.dart';
import 'package:news_flutter_app/features/daily_news/domain/entities/article.dart';
import 'package:news_flutter_app/features/daily_news/domain/repository/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _newsApiService;
  final AppDatabase _appDatabase;

  ArticleRepositoryImpl(this._newsApiService, this._appDatabase);
  @override
  Future<DataState<List<ArticleModel>>> getNewsArticles() async {
    try {
      final httpResponce = await _newsApiService.getNewsArticles(
        apiKey: newsAPIKey,
        country: countryQuery,
        category: categoryQuery,
        language: languageQuery,
      );
      if (httpResponce.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponce.data);
      } else {
        return DataFailed(
          DioException(
            error: httpResponce.response.statusMessage,
            response: httpResponce.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponce.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      print(e);
      return DataFailed(e);
    }
  }

  @override
  Future<List<ArticleModel>> getSavedArticles() {
    return _appDatabase.articleDAO.getArticles();
  }

  @override
  Future<void> removeArticle(ArticleEntity article) {
    return _appDatabase.articleDAO
        .deleteArticle(ArticleModel.fromEntity(article));
  }

  @override
  Future<void> saveArticle(ArticleEntity article) {
    return _appDatabase.articleDAO
        .insertArticle(ArticleModel.fromEntity(article));
  }
}
