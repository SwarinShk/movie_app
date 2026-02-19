import 'package:flutter/material.dart';
import 'package:movie_app/features/movie/data/models/movie_category_model.dart';
import 'package:movie_app/features/movie/data/models/paginated_movie_model.dart';
import 'package:movie_app/features/movie/data/services/movie_service.dart';

class MovieProvider extends ChangeNotifier {
  final MovieService tmdbService = MovieService();

  final Map<MovieCategory, PaginatedMovieModel?> _movies = {
    MovieCategory.nowPlaying: null,
    MovieCategory.upcoming: null,
    MovieCategory.popular: null,
    MovieCategory.topRated: null,
  };

  final Map<MovieCategory, bool> _isLoading = {
    MovieCategory.nowPlaying: false,
    MovieCategory.upcoming: false,
    MovieCategory.popular: false,
    MovieCategory.topRated: false,
  };

  final Map<MovieCategory, bool> _isFetchingMore = {
    MovieCategory.nowPlaying: false,
    MovieCategory.upcoming: false,
    MovieCategory.popular: false,
    MovieCategory.topRated: false,
  };

  final Map<MovieCategory, String?> _error = {
    MovieCategory.nowPlaying: null,
    MovieCategory.upcoming: null,
    MovieCategory.popular: null,
    MovieCategory.topRated: null,
  };

  PaginatedMovieModel? movies(MovieCategory category) => _movies[category];

  bool isLoading(MovieCategory category) => _isLoading[category] ?? false;

  bool isFetchingMore(MovieCategory category) =>
      _isFetchingMore[category] ?? false;

  String? error(MovieCategory category) => _error[category];

  bool hasMorePages(MovieCategory category) {
    final data = _movies[category];
    if (data == null) return false;
    return data.page < data.totalPages;
  }

  Future<void> fetchMovies(MovieCategory category) async {
    _isLoading[category] = true;
    _error[category] = null;
    notifyListeners();

    try {
      final response = await tmdbService.getMovies(
        'movie/${category.apiPath}',
        queryParameters: {'page': '1'},
      );

      _movies[category] = response;
    } catch (e) {
      _error[category] = e.toString();
      _movies[category] = null;
    } finally {
      _isLoading[category] = false;
      notifyListeners();
    }
  }

  Future<void> fetchNextPage(MovieCategory category) async {
    if (_isFetchingMore[category] == true ||
        _isLoading[category] == true ||
        !hasMorePages(category)) {
      return;
    }

    _isFetchingMore[category] = true;
    notifyListeners();

    try {
      final currentData = _movies[category];
      if (currentData == null) return;

      final nextPage = currentData.page + 1;

      final response = await tmdbService.getMovies(
        'movie/${category.apiPath}',
        queryParameters: {'page': nextPage.toString()},
      );

      _movies[category] = currentData.merge(response);
    } catch (e) {
      _error[category] = e.toString();
    } finally {
      _isFetchingMore[category] = false;
      notifyListeners();
    }
  }

  void clearCategory(MovieCategory category) {
    _movies[category] = null;
    _error[category] = null;
    _isLoading[category] = false;
    _isFetchingMore[category] = false;
    notifyListeners();
  }
}
