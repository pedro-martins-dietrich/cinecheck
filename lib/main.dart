import 'package:flutter/material.dart';

import 'pages/home.dart';
import 'pages/search_movie.dart';

void main() {
  runApp(const Cinecheck());
}

class Cinecheck extends StatelessWidget {
  const Cinecheck({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cinecheck',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 200, 10, 10)),
        useMaterial3: true,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomePage(),
        '/search': (context) => const SearchMoviePage(),
      },
    );
  }
}