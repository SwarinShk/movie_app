import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/config/api_config.dart';
import 'package:movie_app/features/movie/data/models/paginated_movie_model.dart';
import 'package:movie_app/features/search/data/models/person_model.dart';
import 'package:movie_app/features/tv/data/models/tv_model.dart';

class SearchService {
  final String baseUrl = ApiConfig.baseUrl;
  final String apiKey = ApiConfig.apiKey;

  Future<PaginatedMovieModel> searchMovies(String text, {int page = 1}) async {
    final uri = Uri.parse(
      '$baseUrl/search/movie?api_key=$apiKey&query=$text&page=$page',
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return PaginatedMovieModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Search failed (Status: ${response.statusCode})');
    }
  }

  Future<TvModel> searchTv(String text, {int page = 1}) async {
    final uri = Uri.parse(
      '$baseUrl/search/tv?api_key=$apiKey&query=$text&page=$page',
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return TvModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Search failed (Status: ${response.statusCode})');
    }
  }

  Future<PersonModel> searchPerson(String text, {int page = 1}) async {
    final uri = Uri.parse(
      '$baseUrl/search/person?api_key=$apiKey&query=$text&page=$page',
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return PersonModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Search failed (Status: ${response.statusCode})');
    }
  }
}
