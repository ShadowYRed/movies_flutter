import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class MovieService {
  static const String _baseUrl = 'https://devsapihub.com/api-movies';

  static Future<List<Movie>> fetchMovies() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => Movie.fromJson(e)).toList();
    } else {
      throw Exception('Error al cargar películas');
    }
  }
}
