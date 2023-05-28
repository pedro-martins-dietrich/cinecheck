import 'package:flutter/material.dart';

import 'package:cinecheck/service/main_page_router.dart';

MainPageRouter _searchPageRouter = MainPageRouter(pageRoute: '/search');

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        elevation: 5,
        centerTitle: true,
        title: Text(
          'Cinecheck',
          style: TextStyle(
            color: colorScheme.onPrimary,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 5),
            child: Image.asset(
              'assets/cinecheck_homepage.png',
            ),
          ),
          const Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
              child: Column(
                children: [
                  Text(
                    'Search for your movies here.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    '\t\t\t\tThis application allows users to search for movies, sorting them by year (most recent to oldest) and by title, using the API "The Movie Database".',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          BottomNavigationBar(
            currentIndex: 0,
            backgroundColor: colorScheme.primary,
            selectedItemColor: colorScheme.onPrimary,
            unselectedItemColor: colorScheme.secondary,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: colorScheme.secondary),
                activeIcon: Icon(Icons.home, color: colorScheme.onPrimary),
                label: 'Home page'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search, color: colorScheme.secondary),
                activeIcon: Icon(Icons.search, color: colorScheme.onPrimary),
                label: 'Search movies'
              ),
            ],
            onTap: (value) {
              if(value == 1) {
                Navigator.of(context).pushReplacement(_searchPageRouter.mainPageRoute());
              }
            },
          ),
        ],
      ),
    );
  }
}