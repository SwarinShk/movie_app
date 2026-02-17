import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_category_model.dart';
import 'package:movie_app/models/paginated_movie_model.dart';
import 'package:movie_app/services/tmdb_service.dart';

class MovieProvider extends ChangeNotifier {
  final TMDBService tmdbService = TMDBService();

  Map<MovieCategory, List<Movie>> movies = {
    MovieCategory.nowPlaying: [],
    MovieCategory.upcoming: [],
    MovieCategory.popular: [],
    MovieCategory.topRated: [],
  };

  Map<MovieCategory, bool> isLoading = {
    MovieCategory.nowPlaying: false,
    MovieCategory.upcoming: false,
    MovieCategory.popular: false,
    MovieCategory.topRated: false,
  };

  Map<MovieCategory, String?> error = {
    MovieCategory.nowPlaying: null,
    MovieCategory.upcoming: null,
    MovieCategory.popular: null,
    MovieCategory.topRated: null,
  };

  Map<MovieCategory, int> currentPage = {
    MovieCategory.nowPlaying: 1,
    MovieCategory.upcoming: 1,
    MovieCategory.popular: 1,
    MovieCategory.topRated: 1,
  };

  Map<MovieCategory, int> totalPages = {
    MovieCategory.nowPlaying: 1,
    MovieCategory.upcoming: 1,
    MovieCategory.popular: 1,
    MovieCategory.topRated: 1,
  };

  Map<MovieCategory, bool> isFetchingMore = {
    MovieCategory.nowPlaying: false,
    MovieCategory.upcoming: false,
    MovieCategory.popular: false,
    MovieCategory.topRated: false,
  };

  Future<void> fetchMovies(MovieCategory category) async {
    currentPage[category] = 1;
    movies[category] = [];

    isLoading[category] = true;
    error[category] = null;
    notifyListeners();

    try {
      final response = await tmdbService.getMovies(
        'movie/${category.apiPath}',
        queryParameters: {'page': '1'},
      );

      movies[category] = response.results;
      totalPages[category] = response.totalPages;
    } catch (e) {
      error[category] = e.toString();
    } finally {
      isLoading[category] = false;
      notifyListeners();
    }
  }

  Future<void> fetchNextPage(MovieCategory category) async {
    if (isFetchingMore[category] == true) return;

    if (currentPage[category]! >= totalPages[category]!) return;

    isFetchingMore[category] = true;
    notifyListeners();

    try {
      final nextPage = currentPage[category]! + 1;

      final response = await tmdbService.getMovies(
        'movie/${category.apiPath}',
        queryParameters: {'page': nextPage.toString()},
      );

      movies[category]!.addAll(response.results);
      currentPage[category] = nextPage;
    } catch (e) {
      error[category] = e.toString();
    } finally {
      isFetchingMore[category] = false;
      notifyListeners();
    }
  }
}
