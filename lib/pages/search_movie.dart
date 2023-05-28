import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:cinecheck/pages/view_movie.dart';
import 'package:cinecheck/models/movie.dart';
import 'package:cinecheck/service/main_page_router.dart';
import 'package:cinecheck/service/movie_list_getter.dart';

class SearchMoviePage extends StatefulWidget {
  const SearchMoviePage({super.key});

  @override
  State<SearchMoviePage> createState() => _SearchMovieState();
}

class _SearchMovieState extends State<SearchMoviePage> {
  final MainPageRouter _mainPageRouter = MainPageRouter(pageRoute: '/home');
  final MovieListGetter _movieListGetter = MovieListGetter();

  int currentPage = 1;
  String currentSearch = '';

  // Default value for the results widget
  Widget results = const Center(
    child: Text('Search for a movie.'),
  );

  // Creates the list of movies using Card Widgets
  List<Widget> createMovieCards(List<Movie> movieList) {
    return [
      for(Movie movie in movieList)
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ViewMoviePage(movie: movie);
            }));
          },
          child: Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Row(
              children: [
                SizedBox(
                  width: 120,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      height: 155,
                      color: Colors.grey[400],
                      child: Hero(
                        tag: 'moviePoster${movie.id}',
                        child: (movie.posterPath == '') ?
                        Image.asset('assets/no_movie_poster.png') :
                        CachedNetworkImage(
                          key: ValueKey(movie.id),
                          imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      width: 240,
                      child: Text(
                        movie.title,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Release year: ${movie.releaseDate == '' ? 'Not available.' : movie.releaseDateTime.year}',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
    ];
  }

  // Creates a ListView with the movie list
  void showSearchResults(String searchString) async {
    await _movieListGetter.getMovieList(searchString, currentPage);
    List<Widget> movieCards = createMovieCards(_movieListGetter.movieList);

    setState(() {
      if (movieCards.isNotEmpty) {
        results = ListView.builder(
          padding: const EdgeInsets.all(10),
          controller: ScrollController(),
          itemCount: movieCards.length + 1,
          itemBuilder: (BuildContext context, int index) {
            return (index != movieCards.length) ?
            movieCards[index] :
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 45),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.primary),
                ),
                onPressed: () {
                  showSearchResults(currentSearch);
                },
                child: Text(
                  'Show more results',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 14,
                  )
                ),
              ),
            );
          },
        );
      } else {
        results = const Center(
          child: Text('No results found.'),
        );
      }
      currentSearch = searchString;
      currentPage++;
    });
  }

  void resetCurrentPage() {
    setState(() {
      currentPage = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        elevation: 5,
        centerTitle: true,
        title: Text(
          'Search Movie',
          style: TextStyle(
            color: colorScheme.onPrimary,
            fontSize: 28,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15),
            child: SearchBar(
              leading: const Icon(Icons.search),
              hintText: 'Search movies',
              onChanged: (value) {
                resetCurrentPage();
                showSearchResults(value);
              },
            ),
          ),
          Expanded(
            child: Center(
              child: results,
            ),
          ),
          BottomNavigationBar(
            currentIndex: 1,
            elevation: 5,
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
              if(value == 0) {
                Navigator.of(context).pushReplacement(_mainPageRouter.mainPageRoute());
              }
            },
          ),
        ],
      ),
    );
  }
}