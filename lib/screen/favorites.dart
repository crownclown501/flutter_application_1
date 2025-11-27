import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/colores_app.dart';
import 'package:flutter_application_1/components/multidata.dart';
import 'package:flutter_application_1/main.dart'; 
import 'package:flutter_application_1/models/movie.dart';
import 'package:flutter_application_1/services/movie_service.dart';


class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  late Future<List<Movie>> _afuturo;

  @override
  void initState() {
    super.initState();
    _afuturo = MovieService.fetchMovies();  
  }

  List<Movie> _filterFavorites(List<Movie> movies) {
    return movies.where((movie) => favoriteIds.contains(movie.id)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColoresApp.background,
      appBar: AppBar(
        title: const Text('Películas Favoritas'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Multidata(
          peli: _afuturo,
          filtradodatos: _filterFavorites, // Pasa el filtro
          showBackButton: true, // Muestra botón de regresar
          onBackPressed: () {
            Navigator.pop(context); // Regresa
          },
        ),
      ),
    );
  }
}