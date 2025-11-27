import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/colores_app.dart';
import 'package:flutter_application_1/core/estilos_texto.dart';
import 'package:flutter_application_1/models/movie.dart';
import 'package:flutter_application_1/screen/movie_detail.dart';

class Multidata extends StatelessWidget {
  final Future<List<Movie>> peli;
  final List<Movie> Function(List<Movie>)? filtradodatos; // esta funcion es de favorites unicamente
  final VoidCallback? onRefresh; // Para que podamos refrescar en el de vista
  final bool showBackButton; // Para mostrar botón de regresar en Favorites
  final VoidCallback? onBackPressed; // Callback para regresar

  const Multidata({
    super.key,
    required this.peli,
    this.filtradodatos,
    this.onRefresh,
    this.showBackButton = false,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder<List<Movie>>(
            future: peli,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error al cargar películas'));
              } else {
                List<Movie> movies = snapshot.data!;
                if (filtradodatos != null) {
                  movies = filtradodatos!(movies); 
                }
                if (movies.isEmpty) {
                  return const Center(
                    child: Text(
                      'No hay películas disponibles',
                      style: EstilosTexto.textoBody,
                    ),
                  );
                }
                return ListView(
                  children: movies.map((movie) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetail(movie: movie),
                          ),
                          
                        );
                      },
                      child: GeneralData(movie),
                    );
                  }).toList(),
                );
              }
            },
          ),
        ),
        // Botón 
        Boton_vista_y_favorites(),
      ],
    );
  }







  // ignore: non_constant_identifier_names
  Padding Boton_vista_y_favorites() {
    return Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 2, left: 8, right: 8),
        child: ElevatedButton(
          onPressed: showBackButton ? onBackPressed : onRefresh,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                showBackButton ? "Regresar a Cartelera" : "Refrescar Cartelera",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
  }

  // ignore: non_constant_identifier_names
  Padding GeneralData(Movie movie) {
    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColoresApp.backgroundComponente,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            movie.posterPath.isNotEmpty
                                ? Image.network(
                                    'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                                    width: 100,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    width: 100,
                                    height: 150,
                                    color: Colors.grey,
                                  ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      movie.title,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Fecha: ${movie.releaseDate}',
                                      style: EstilosTexto.textoBody,
                                    ),
                                    Text(
                                        movie.overview.length > 100                   //se añade los puntitos ya que es una interpolacion ademas de que indica que sigue texto
                                            ? '${movie.overview.substring(0, 100)}...' //se eecuta si es verdad si no
                                            : movie.overview,                         //aqui se ejecuta
                                        style: EstilosTexto.textoBody,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
  }
}