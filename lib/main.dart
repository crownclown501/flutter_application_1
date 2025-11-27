// ignore_for_file: unused_import



import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/colores_app.dart';
import 'package:flutter_application_1/screen/vista.dart';
  // Cambiado de imc_home.dart



List<int> favoriteIds = [];
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cartelera de Películas'),
          foregroundColor: Colors.white,
          backgroundColor: Colors.purple,
        ),
        backgroundColor: ColoresApp.background,
        body: Vista(),
      ),
    );
  }
}