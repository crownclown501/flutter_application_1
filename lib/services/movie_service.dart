import 'dart:convert';  // Para json.decode
import 'package:http/http.dart' as http;  // Nuevo: para requests HTTP
import '../models/movie.dart';

class MovieService {
  static const String apiUrl = 'https://api.themoviedb.org/3/discover/movie?primary_release_date.gte=2024-09-01&primary_release_date.lte=2025-09-31&api_key=244f263df90bdc15f157fbcaa4219fd1&language=es&include_image_language=es&page=1';
  //siempre que usemos un async debe de llevar un await 
    static Future<List<Movie>> fetchMovies() async {
    final response = await http.get(Uri.parse(apiUrl)); 
    if (response.statusCode == 200) {
      final data = json.decode(response.body);  
      final List<dynamic> results = data['results'];
      return results.map((json) => Movie.fromJson(json)).toList();  // creamos una lista para las peliculas
    } else {
      throw Exception('Error al cargar películas');  //por si hay algun fallo -> lanza el error
    }
  }
}