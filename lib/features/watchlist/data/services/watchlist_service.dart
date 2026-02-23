import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/config/api_config.dart';
import 'package:movie_app/features/movie/data/models/paginated_movie_model.dart';
import 'package:movie_app/features/tv/data/models/tv_model.dart';

class WatchlistService {
  final String apiKey = ApiConfig.apiKey;
  final String baseUrl = ApiConfig.baseUrl;

  /// Add or remove item from watchlist
  Future<void> addToWatchlist({
    required int accountId,
    required String sessionId,
    required int mediaId,
    required String mediaType,
    required bool addToWatchlist,
  }) async {
    final url = Uri.parse(
      '$baseUrl/account/$accountId/watchlist?api_key=$apiKey&session_id=$sessionId',
    );

    await http.post(
      url,
      headers: {'Content-Type': 'application/json;charset=utf-8'},
      body: jsonEncode({
        'media_type': mediaType,
        'media_id': mediaId,
        'watchlist': addToWatchlist,
      }),
    );
  }

  /// Fetch movie watchlist (paginated)
  Future<PaginatedMovieModel> fetchMovieWatchlist({
    required int accountId,
    required String sessionId,
    int page = 1,
  }) async {
    final json = await _getJson(
      '$baseUrl/account/$accountId/watchlist/movies?api_key=$apiKey&session_id=$sessionId&page=$page',
    );
    return PaginatedMovieModel.fromJson(json);
  }

  /// Fetch TV watchlist (paginated)
  Future<TvModel> fetchTvWatchlist({
    required int accountId,
    required String sessionId,
    int page = 1,
  }) async {
    final json = await _getJson(
      '$baseUrl/account/$accountId/watchlist/tv?api_key=$apiKey&session_id=$sessionId&page=$page',
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
