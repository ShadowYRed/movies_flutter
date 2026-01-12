import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/movie_service.dart';

class MovieProvider extends ChangeNotifier {
  static const int pageSize = 5;

  List<Movie> _allMovies = [];
  List<Movie> _visibleMovies = [];

  bool _loading = true;
  bool _loadingMore = false;

  int _visibleCount = pageSize;
  String _search = '';

  List<Movie> get movies => _visibleMovies;
  bool get loading => _loading;
  bool get loadingMore => _loadingMore;

  Future<void> loadMovies() async {
    try {
      final movies = await MovieService.fetchMovies();
      _allMovies = movies;
      _visibleMovies = movies.take(_visibleCount).toList();
      _loading = false;
      notifyListeners();
    } catch (_) {
      _loading = false;
      notifyListeners();
    }
  }

  void search(String query) {
    _search = query.toLowerCase();
    _visibleCount = pageSize;

    final source = _filterSource();
    _visibleMovies = source.take(_visibleCount).toList();
    notifyListeners();
  }

  void loadMore() {
    if (_loadingMore) return;

    final source = _filterSource();
    if (_visibleCount >= source.length) return;

    _loadingMore = true;
    notifyListeners();

    Future.delayed(const Duration(milliseconds: 400), () {
      _visibleCount = (_visibleCount + pageSize).clamp(0, source.length);
      _visibleMovies = source.take(_visibleCount).toList();
      _loadingMore = false;
      notifyListeners();
    });
  }

  List<Movie> _filterSource() {
    if (_search.isEmpty) return _allMovies;

    return _allMovies.where((movie) {
      return movie.title.toLowerCase().contains(_search) ||
          movie.description.toLowerCase().contains(_search) ||
          movie.genre.toLowerCase().contains(_search) ||
          movie.year.toString().contains(_search) ||
          movie.stars.toString().contains(_search);
    }).toList();
  }
}
