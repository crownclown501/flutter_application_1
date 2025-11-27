import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/multidata.dart';
import 'package:flutter_application_1/models/movie.dart';
import 'package:flutter_application_1/services/movie_service.dart';

class Vista extends StatefulWidget {
  const Vista({super.key});

  @override
  State<Vista> createState() => _VistaState();
}

class _VistaState extends State<Vista> {
  late Future<List<Movie>> _peliculas;

  @override
  void initState() {
    super.initState();
    _peliculas = MovieService.fetchMovies();
  }

  void _refreshMovies() {
    setState(() {
      _peliculas = MovieService.fetchMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Multidata(
      peli: _peliculas,
      onRefresh: _refreshMovies,
    );
  }
}