import 'dart:io';

import 'package:dio/dio.dart';
import 'package:news_flutter_app/core/constants/constants.dart';
import 'package:news_flutter_app/core/resources/data_state.dart';
import 'package:news_flutter_app/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:news_flutter_app/features/daily_news/data/models/article.dart';
import 'package:news_flutter_app/features/daily_news/domain/repository/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _newsApiService;

  ArticleRepositoryImpl(this._newsApiService);
  @override
  Future<DataState<List<ArticleModel>>> getNewsArticles() async {
    try {
      final httpResponce = await _newsApiService.getNewsArticles(
        apiKey: newsAPIKey,
        country: countryQuery,
        category: categoryQuery,
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
}
