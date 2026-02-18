import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/features/movie/data/models/movie_credits_model.dart';
import 'package:movie_app/features/movie/data/models/movie_detail_model.dart';
import 'package:movie_app/features/movie/data/models/paginated_movie_model.dart';
import 'package:movie_app/features/search/data/models/search_model.dart';

class TMDBService {
  final String baseUrl = dotenv.env['TMDB_BASE_URL']!;
  final String apiKey = dotenv.env['TMDB_API_KEY']!;

  Future<PaginatedMovieModel> getMovies(
    String endpoint, {
    Map<String, String>? queryParameters,
  }) async {
    try {
      final uri = Uri.parse(
        '$baseUrl/$endpoint',
      ).replace(queryParameters: {'api_key': apiKey, ...?queryParameters});

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        return PaginatedMovieModel.fromJson(json.decode(response.body));
      } else {
        throw Exception("Failed to fetch movies");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'API Error: $e');
      throw Exception("Failed to fetch movies");
    }
  }

  Future<MovieDetail> fetchMovieDetail(int movieId) async {
    final uri = Uri.parse("$baseUrl/movie/$movieId?api_key=$apiKey");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return MovieDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to fetch movies details");
    }
  }

  Future<MovieCredits> fetchMovieCredit(int movieId) async {
    final uri = Uri.parse("$baseUrl/movie/$movieId/credits?api_key=$apiKey");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return MovieCredits.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to fetch movies credit");
    }
  }

  Future<PaginatedMovieModel> fetchSimilar(int movieId) async {
    final uri = Uri.parse("$baseUrl/movie/$movieId/similar?api_key=$apiKey");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return PaginatedMovieModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to fetch recommended movies");
    }
  }

  Future<SearchModel> fetchSearch(String text, {int page = 1}) async {
    final uri = Uri.https('api.themoviedb.org', '/3/search/multi', {
      'api_key': apiKey,
      'query': text,
      'page': page.toString(),
      'include_adult': 'false',
    });

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return SearchModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Search failed (Status: ${response.statusCode})');
    }
  }
}
