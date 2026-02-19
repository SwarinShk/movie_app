import 'package:flutter/material.dart';
import 'package:movie_app/features/movie/data/models/movie_credits_model.dart';
import 'package:movie_app/features/movie/data/models/movie_detail_model.dart';
import 'package:movie_app/features/movie/data/models/paginated_movie_model.dart';
import 'package:movie_app/features/movie/data/services/movie_service.dart';

class MovieDetailProvider extends ChangeNotifier {
  final MovieService _service = MovieService();

  MovieDetail? _movie;
  MovieCredits? _credit;
  List<Movie>? _recommended;

  bool _isLoading = false;
  String? _error;

  MovieDetail? get movie => _movie;
  MovieCredits? get credit => _credit;
  List<Movie>? get recommended => _recommended;

  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchMovieDetail(int movieId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _service.fetchMovieDetail(movieId);

      _movie = response;
    } catch (e) {
      _error = e.toString();
      _movie = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMovieCredit(int movieId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _service.fetchMovieCredit(movieId);

      _credit = response;
    } catch (e) {
      _error = e.toString();
      _credit = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchSimilar(int movieId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _service.fetchSimilar(movieId);

      _recommended = response.results;
      debugPrint(_recommended!.first.title);
    } catch (e) {
      _error = e.toString();
      _recommended = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
