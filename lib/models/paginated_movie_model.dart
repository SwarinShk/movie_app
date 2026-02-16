import 'package:movie_app/models/dates_model.dart';
import 'package:movie_app/models/movie_model.dart';

class PaginatedMovieModel {
  final Dates? dates;
  final int page;
  final List<Movie> results;
  final int totalPages;
  final int totalResults;

  PaginatedMovieModel({
    this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory PaginatedMovieModel.fromJson(Map<String, dynamic> json) {
    return PaginatedMovieModel(
      dates: json['dates'] != null ? Dates.fromJson(json['dates']) : null,
      page: json['page'] ?? 1,
      results: (json['results'] as List<dynamic>? ?? [])
          .map((e) => Movie.fromJson(e))
          .toList(),
      totalPages: json['total_pages'] ?? 1,
      totalResults: json['total_results'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dates': dates?.toJson(),
      'page': page,
      'results': results.map((e) => e.toJson()).toList(),
      'total_pages': totalPages,
      'total_results': totalResults,
    };
  }
}
