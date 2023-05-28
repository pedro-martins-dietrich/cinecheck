import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:cinecheck/models/movie.dart';
import 'package:cinecheck/service/movie_sorter.dart';

class MovieListGetter {
  final String _apiUri = 'https://api.themoviedb.org/3/search/movie';
  final String _apiKey = '5d9908e651ba27b49655802b3e5db2fe';

  final MovieSorter movieSorter = MovieSorter();

  List<Movie> movieList = [];

  // Creates the URI for the search request
  Uri createSearchUri(String query, int page) {
    String formatedQuery = query.replaceAll(' ', '+');
    String searchUriString = '$_apiUri?api_key=$_apiKey&query=$formatedQuery&page=$page';
    return Uri.parse(searchUriString);
  }

  // Fetches a list of searched movies from the API
  Future<void> getMovieList(String searchString, int page) async {
    try {
      List<Movie> tempMovieList = [];
      http.Response response = await http.get(createSearchUri(searchString, page));

      if (response.statusCode == 200) {
        Map<String, dynamic> movieListData = jsonDecode(response.body);

        for (Map<String, dynamic> movieData in movieListData['results']) {
          tempMovieList.add(Movie.fromJson(movieData));
        }

        if (page > 1) {
          movieList.addAll(tempMovieList);
        } else {
          movieList = tempMovieList;
        }

        movieSorter.sortMovies(movieList);

      } else {
        throw Exception('Request failed.\nStatus code: ${response.statusCode}');
      }
    } catch(error) {
      throw Exception('Failed to load movies.\n$error');
    }
  }
}