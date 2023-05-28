import 'package:flutter/material.dart';

import 'package:cinecheck/pages/home.dart';
import 'package:cinecheck/pages/search_movie.dart';

class MainPageRouter {
  String pageRoute;

  MainPageRouter({required this.pageRoute});

  Route mainPageRoute() {
    double xOffset = pageRoute == '/home' ? -1.0 : 1.0;

    return PageRouteBuilder(
      pageBuilder: ((context, animation, secondaryAnimation) => (pageRoute == '/home') ? const HomePage() : const SearchMoviePage()),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        Animatable<Offset> tween = Tween(
          begin: Offset(xOffset, 0.0),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.ease));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      }
    );
  }
}