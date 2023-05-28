import 'package:cinecheck/models/movie.dart';

class MovieSorter {
  List<Movie> sortMovies(List<Movie> movieList) {
    if (movieList.length <= 1) {
      return movieList;
    }

    movieList = sort(movieList, compareYears);
    movieList = divideAndSortByTitle(movieList);

    return movieList;
  }

  // Uses Merge Sort to sort movies by year or title
  List<Movie> sort(movieList, Function(Movie, Movie) compare) {
    if (movieList.length <= 1) {
      return movieList;
    }

    int centerIndex = (movieList.length/2).ceil();
    List<Movie> leftList = movieList.sublist(0, centerIndex);
    List<Movie> rightList = movieList.sublist(centerIndex, movieList.length);

    sort(leftList, compare);
    sort(rightList, compare);

    int leftIndex = 0;
    int rightIndex = 0;
    int movieIndex = 0;

    while (leftIndex < centerIndex && rightIndex < rightList.length) {
      if (compare(leftList[leftIndex], rightList[rightIndex]) == -1) {
        movieList[movieIndex] = leftList[leftIndex];
        leftIndex++;
      } else {
        movieList[movieIndex] = rightList[rightIndex];
        rightIndex++;
      }
      movieIndex++;
    }

    while (leftIndex < leftList.length) {
      movieList[movieIndex] = leftList[leftIndex];
      leftIndex++;
      movieIndex++;
    }

    while (rightIndex < rightList.length) {
      movieList[movieIndex] = rightList[rightIndex];
      rightIndex++;
      movieIndex++;
    }

    return movieList;
  }

  // Sorts the movie list by name within each year
  List<Movie> divideAndSortByTitle(List<Movie> movieList) {
    int startYearIndex = 0;
    int endYearIndex;
    int movieIndex = 1;
    int currentYear;

    while (movieIndex < movieList.length) {
      // Checks the year and selects the movies from that year
      currentYear = movieList[startYearIndex].releaseDateTime.year;
      while (movieIndex < movieList.length && movieList[movieIndex].releaseDateTime.year == currentYear) {
        movieIndex++;
      }
      endYearIndex = movieIndex;

      // Only sort if there is more than 1 movie in a year
      if(endYearIndex - startYearIndex > 1) {
        List<Movie> currentYearList = movieList.sublist(startYearIndex, endYearIndex);
        currentYearList = sort(currentYearList, compareTitles);
        movieList.replaceRange(startYearIndex, endYearIndex, currentYearList);
      }
      startYearIndex = endYearIndex;
    }
    return movieList;
  }

  // Returns -1 if m1 is more recent
  int compareYears(Movie m1, Movie m2) {
    if(m1.releaseDateTime.year > m2.releaseDateTime.year) {
      return -1;  // year1 > year2
    } else if (m1.releaseDateTime.year < m2.releaseDateTime.year) { 
      return 1;   // year1 < year2
    } else {
      return 0;   // year1 == year2
    }
  }

  // Returns -1 if m1 is first in alphabetical order
  int compareTitles(Movie m1, Movie m2) {
    return m1.title.toLowerCase().compareTo(m2.title.toLowerCase());
  }
}