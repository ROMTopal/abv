class Movie {
  final String poster;
  final int likes;
  final String title;
  final int year;
  final String runtime;
  final String rated;
  final List<String> genre;

  Movie({
    required this.genre,
    required this.likes,
    required this.poster,
    required this.rated,
    required this.runtime,
    required this.title,
    required this.year,
  });

  Movie.fromJson(Map<String, Object?> json)
      : this(
    genre: (json['genre']! as List).cast<String>(),
    likes: json['likes']! as int,
    poster: json['poster']! as String,
    rated: json['rated']! as String,
    runtime: json['runtime']! as String,
    title: json['title']! as String,
    year: json['year']! as int,
  );



  Map<String, Object?> toJson() {
    return {
      'genre': genre,
      'likes': likes,
      'poster': poster,
      'rated': rated,
      'runtime': runtime,
      'title': title,
      'year': year,
    };
  }
}