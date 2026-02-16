import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
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

  Future<void> fetchMovies(MovieCategory category) async {
    isLoading[category] = true;
    error[category] = null;
    notifyListeners();

    final endpoint = _getEndpoint(category);

    try {
      isLoading[category] = true;
      error[category] = null;
      notifyListeners();

      final response = await tmdbService.getMovies('movie/$endpoint');

      movies[category] = response.results;
    } catch (e) {
      error[category] = e.toString();
    } finally {
      isLoading[category] = false;
      notifyListeners();
    }
  }

  String _getEndpoint(MovieCategory category) {
    switch (category) {
      case MovieCategory.nowPlaying:
        return 'now_playing';
      case MovieCategory.upcoming:
        return 'upcoming';
      case MovieCategory.popular:
        return 'popular';
      case MovieCategory.topRated:
        return 'top_rated';
    }
  }
}
