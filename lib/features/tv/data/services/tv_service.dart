import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/config/api_config.dart';
import 'package:movie_app/features/tv/data/models/tv_credits_model.dart';
import 'package:movie_app/features/tv/data/models/tv_detail_model.dart';
import 'package:movie_app/features/tv/data/models/tv_model.dart';

class TvService {
  final String baseUrl = ApiConfig.baseUrl;
  final String apiKey = ApiConfig.apiKey;

  Future<TvModel> getTv(
    String endpoint, {
    Map<String, String>? queryParameters,
  }) async {
    try {
      final uri = Uri.parse(
        '$baseUrl/$endpoint',
      ).replace(queryParameters: {'api_key': apiKey, ...?queryParameters});

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        return TvModel.fromJson(json.decode(response.body));
      } else {
        throw Exception("Failed to fetch movies");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'API Error: $e');
      throw Exception("Failed to fetch movies");
    }
  }

  Future<TvDetail> fetchTvDetail(int tvId) async {
    final uri = Uri.parse("$baseUrl/tv/$tvId?api_key=$apiKey");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return TvDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to fetch movies details");
    }
  }

  Future<TvCredits> fetchTvCredit(int tvId) async {
    final uri = Uri.parse("$baseUrl/tv/$tvId/credits?api_key=$apiKey");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return TvCredits.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to fetch movies credit");
    }
  }

  Future<TvModel> fetchSimilar(int tvId) async {
    final uri = Uri.parse("$baseUrl/tv/$tvId/similar?api_key=$apiKey");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return TvModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to fetch recommended movies");
    }
  }
}
