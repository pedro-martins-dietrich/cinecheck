class Movie {
  final int id;
  final String title;
  final String releaseDate;
  late DateTime releaseDateTime;
  final String overview;
  final dynamic posterPath;
  final double voteAverage;

  Movie({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
  }) {
    if (releaseDate != '') {
      releaseDateTime = DateTime.parse(releaseDate);
    } else {
      releaseDateTime = DateTime(0);
    }
  }

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      releaseDate: json['release_date'],
      overview: json['overview'],
      posterPath: (json['poster_path'] == null) ? '' : json['poster_path'],
      voteAverage: json['vote_average'],
    );
  }

  String formatedDate() {
    if (releaseDate == '') {
      return 'Not provided.';
    }
    return '${releaseDateTime.day}/${releaseDateTime.month}/${releaseDateTime.year}';
  }
}