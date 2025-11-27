import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/colores_app.dart';
import 'package:flutter_application_1/core/estilos_texto.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/models/movie.dart';
import 'package:flutter_application_1/screen/favorites.dart';
// import 'package:flutter_application_1/screen/vista.dart';

class MovieDetail extends StatefulWidget { 
  final Movie movie;
  const MovieDetail({super.key, required this.movie});

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {  
  bool _isFavorite = false;  
  void _toggleFavorite() {  //funcion para cambiar estado de boton y de lista
    setState(() {
      if (_isFavorite) {
        favoriteIds.remove(widget.movie.id);  // Quita
      } else {
        favoriteIds.add(widget.movie.id);  // Agrega
      }
      _isFavorite = !_isFavorite;  // Invierte estado
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColoresApp.background,
      appBar: AppBar(
        title: Text(widget.movie.title), 
        foregroundColor: Colors.white,
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            onPressed: _toggleFavorite,  // Llama a la función
            icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Detalles de la Película:", style: TextStyle(fontSize: 35, color: Colors.white, fontWeight: FontWeight.bold)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 15, right: 15, bottom: 30),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColoresApp.backgroundComponente,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        widget.movie.posterPath.isNotEmpty  
                            ? Image.network(
                                'https://image.tmdb.org/t/p/w500${widget.movie.posterPath}',
                                height: 200,
                                fit: BoxFit.cover,
                              )
                            : Container(height: 200, color: Colors.grey),
                        Padding(
                          padding: const EdgeInsets.only(left: 18),
                          child: Text(widget.movie.title, style: TextStyle(fontSize: 30, color: const Color.fromARGB(255, 251, 33, 33), fontWeight: FontWeight.bold)),  // Cambiado: usa widget.movie
                        ),
                        Text('Fecha de lanzamiento: ${widget.movie.releaseDate}', style: EstilosTexto.textoBody),  // Cambiado: usa widget.movie
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.movie.overview, style: TextStyle(fontSize: 18, color: Colors.white), textAlign: TextAlign.center),  // Cambiado: usa widget.movie
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 60,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Favorites()));
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.purple),
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                  ),
                  child: Text('Ir a Favoritos', style: EstilosTexto.textoBody),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}