import 'package:flutter/widgets.dart';
import 'package:movie_app/features/movie/data/models/paginated_movie_model.dart';
import 'package:movie_app/features/search/data/services/search_service.dart';

class SearchMovieProvider extends ChangeNotifier {
  final SearchService _service = SearchService();

  PaginatedMovieModel? _searchMovie;

  bool _isLoading = false;
  bool _isFetchingMore = false;
  String? _error;

  String _currentQuery = '';
  int _currentPage = 1;
  int _totalPages = 1;

  int _requestId = 0;

  // GETTERS

  PaginatedMovieModel? get searchMovie => _searchMovie;
  bool get isLoading => _isLoading;
  bool get isFetchingMore => _isFetchingMore;
  String? get error => _error;
  bool get hasMorePages => _currentPage < _totalPages;

  // INITIAL SEARCH

  Future<void> fetchSearch(String text) async {
    final query = text.trim();
    if (query.isEmpty) return;

    if (query == _currentQuery && _searchMovie != null) return;

    _requestId++;
    final currentRequest = _requestId;

    _isLoading = true;
    _error = null;
    _currentQuery = query;
    _currentPage = 1;
    _totalPages = 1;
    notifyListeners();

    try {
      final response = await _service.searchMovies(query, page: _currentPage);

      if (currentRequest != _requestId) return;

      _searchMovie = response;
      _totalPages = response.totalPages;
    } catch (e) {
      if (currentRequest != _requestId) return;
      _error = e.toString();
      _searchMovie = null;
    } finally {
      if (currentRequest == _requestId) {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  // LOAD MORE (INFINITE SCROLL)

  Future<void> loadMore() async {
    if (_isFetchingMore ||
        _isLoading ||
        !hasMorePages ||
        _currentQuery.isEmpty) {
      return;
    }

    _isFetchingMore = true;
    _error = null;
    notifyListeners();

    final nextPage = _currentPage + 1;

    try {
      final response = await _service.searchMovies(
        _currentQuery,
        page: nextPage,
      );

      if (_searchMovie != null) {
        _searchMovie = _searchMovie!.merge(response);
        _currentPage = nextPage;
        _totalPages = response.totalPages;
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isFetchingMore = false;
      notifyListeners();
    }
  }

  // CLEAR SEARCH

  void clear() {
    _searchMovie = null;
    _currentQuery = '';
    _currentPage = 1;
    _totalPages = 1;
    _error = null;
    _isLoading = false;
    _isFetchingMore = false;
    notifyListeners();
  }
}
