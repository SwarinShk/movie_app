import 'package:flutter/material.dart';
import 'package:movie_app/features/search/data/models/person_model.dart';
import 'package:movie_app/features/search/data/services/search_service.dart';

class SearchPersonProvider extends ChangeNotifier {
  final SearchService _service = SearchService();

  PersonModel? _searchPerson;
  bool _isLoading = false;
  bool _isFetchingMore = false;
  String _currentQuery = '';
  int _currentPage = 1;
  int _totalPages = 1;
  String? _error;

  PersonModel? get searchPerson => _searchPerson;
  bool get isLoading => _isLoading;
  bool get isFetchingMore => _isFetchingMore;
  String? get error => _error;

  Future<void> fetchSearch(String query) async {
    if (query.isEmpty) return;

    _currentQuery = query;
    _currentPage = 1;
    _totalPages = 1;
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _service.searchPerson(query, page: _currentPage);
      _searchPerson = result;
      _totalPages = result.totalPages;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMore() async {
    if (_currentQuery.isEmpty ||
        _isFetchingMore ||
        _currentPage >= _totalPages) {
      return;
    }

    _isFetchingMore = true;
    notifyListeners();

    try {
      final nextPage = _currentPage + 1;
      final result = await _service.searchPerson(_currentQuery, page: nextPage);

      _searchPerson = PersonModel(
        page: result.page,
        results: [...?_searchPerson?.results, ...result.results],
        totalPages: result.totalPages,
        totalResults: result.totalResults,
      );

      _currentPage = result.page;
      _totalPages = result.totalPages;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isFetchingMore = false;
      notifyListeners();
    }
  }

  void clear() {
    _searchPerson = null;
    _currentQuery = '';
    _currentPage = 1;
    _totalPages = 1;
    _error = null;
    _isLoading = false;
    _isFetchingMore = false;
    notifyListeners();
  }
}
