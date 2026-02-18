import 'package:flutter/material.dart';
import 'package:movie_app/features/search/data/models/search_model.dart';
import '../../../movie/data/services/tmdb_service.dart';

class SearchProvider extends ChangeNotifier {
  final TMDBService _service = TMDBService();

  SearchModel? _search;

  bool _isLoading = false;
  bool _isFetchingMore = false;

  String? _error;

  String _currentQuery = '';
  int _currentPage = 1;
  int _totalPages = 1;

  // GETTERS

  SearchModel? get search => _search;
  bool get isLoading => _isLoading;
  bool get isFetchingMore => _isFetchingMore;
  String? get error => _error;

  bool get hasMorePages => _currentPage < _totalPages;

  // INITIAL SEARCH

  Future<void> fetchSearch(String text) async {
    if (text.trim().isEmpty) return;

    try {
      _isLoading = true;
      _error = null;

      _currentQuery = text;
      _currentPage = 1;

      notifyListeners();

      final response = await _service.fetchSearch(text, page: _currentPage);

      _search = response;
      _totalPages = response.totalPages;
    } catch (e) {
      _error = e.toString();
      _search = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // LOAD MORE (INFINITE SCROLL)

  Future<void> loadMore() async {
    if (_isFetchingMore || !hasMorePages || _currentQuery.isEmpty) return;

    try {
      _isFetchingMore = true;
      notifyListeners();

      _currentPage++;

      final response = await _service.fetchSearch(
        _currentQuery,
        page: _currentPage,
      );

      if (_search != null) {
        _search = _search!.merge(response);
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
    _search = null;
    _currentQuery = '';
    _currentPage = 1;
    _totalPages = 1;
    _error = null;
    notifyListeners();
  }
}
