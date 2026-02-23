import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/config/api_config.dart';
import 'package:movie_app/features/movie/data/models/paginated_movie_model.dart';
import 'package:movie_app/features/tv/data/models/tv_model.dart';

class FavoriteService {
  final String apiKey = ApiConfig.apiKey;
  final String baseUrl = ApiConfig.baseUrl;

  /// Add or remove item from watchlist
  Future<void> addToFavorite({
    required int accountId,
    required String sessionId,
    required int mediaId,
    required String mediaType,
    required bool addToFavorite,
  }) async {
    final url = Uri.parse(
      '$baseUrl/account/$accountId/favorite?api_key=$apiKey&session_id=$sessionId',
    );

    await http.post(
      url,
      headers: {'Content-Type': 'application/json;charset=utf-8'},
      body: jsonEncode({
        'media_type': mediaType,
        'media_id': mediaId,
        'favorite': addToFavorite,
      }),
    );
  }

  /// Fetch movie watchlist (paginated)
  Future<PaginatedMovieModel> fetchMovieFavorite({
    required int accountId,
    required String sessionId,
    int page = 1,
  }) async {
    final json = await _getJson(
      '$baseUrl/account/$accountId/favorite/movies?api_key=$apiKey&session_id=$sessionId&page=$page',
    );
    return PaginatedMovieModel.fromJson(json);
  }

  /// Fetch TV watchlist (paginated)
  Future<TvModel> fetchTvFavorite({
    required int accountId,
    required String sessionId,
    int page = 1,
  }) async {
    final json = await _getJson(
      '$baseUrl/account/$accountId/favorite/tv?api_key=$apiKey&session_id=$sessionId&page=$page',
    );
    return TvModel.fromJson(json);
  }

  /// Helper GET request
  Future<Map<String, dynamic>> _getJson(String urlString) async {
    final url = Uri.parse(urlString);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed request: ${response.statusCode}");
    }
  }
}
