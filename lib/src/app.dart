import 'package:flutter/material.dart';
import 'package:proyecto_gibran/src/pages/Slide.dart';
// import 'package:proyecto_gibran/src/paginas/home_pagina.dart';

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Center(
          // child: HomePagina(),
          child: (HomePage())),
    );
  }
}
