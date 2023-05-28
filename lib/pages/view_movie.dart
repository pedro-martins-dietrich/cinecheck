import 'package:flutter/material.dart';

import 'package:cinecheck/models/movie.dart';

class ViewMoviePage extends StatelessWidget {
  final Movie movie;

  const ViewMoviePage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        elevation: 5,
        centerTitle: true,
        title: Text(
          movie.title,
          style: TextStyle(
            fontSize: 18,
            color: colorScheme.onPrimary,
          ),
        ),
      ),
      body: Container(
        color: colorScheme.primaryContainer,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Hero(
                tag: 'moviePoster${movie.id}',
                child: Image.network(
                  'https://image.tmdb.org/t/p/original${movie.posterPath}',
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Container(
                      height: 500,
                      color: Colors.grey[400],
                      child: Center(
                        child: CircularProgressIndicator(
                          color: colorScheme.primary,
                          value: loadingProgress.expectedTotalBytes != null ?
                            loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! :
                            null,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'Movie overview:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '\t\t\t\t${movie.overview}',
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 14,
                ),
            ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 5, 10),
                  child: Text(
                    'Release date:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  movie.formatedDate(),
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 50, right: 5),
                  child: Text(
                    'Rating:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '${double.parse(movie.voteAverage.toStringAsFixed(1))}',
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}