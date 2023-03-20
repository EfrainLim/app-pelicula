import 'package:flutter/material.dart';

class Peliculas {
  List<Pelicula> items = [];

  Peliculas();

  Peliculas.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final pelicula = Pelicula.fromJsonMap(item);
      items.add(pelicula);
    }
  }
}

class Pelicula {
  String uniqueID = '';
  String posterPath = '';
  bool adult = true;
  String overview = '';
  String releaseDate = '';
  List<int> genreIds = [];
  int id = 0;
  String originalTitle = '';
  String originalLanguage = "es";
  String title = '';
  String backdropPath = '';
  double popularity = 0.0;
  int voteCount = 0;
  bool video = false;
  double voteAverage = 0.0;

  Pelicula({
    required this.posterPath,
    required this.adult,
    required this.overview,
    required this.genreIds,
    required this.releaseDate,
    required this.id,
    required this.originalTitle,
    required this.originalLanguage,
    required this.title,
    required this.backdropPath,
    required this.popularity,
    required this.voteCount,
    required this.video,
    required this.voteAverage,
  });
  Pelicula.fromJsonMap(Map<String, dynamic> json) {
    posterPath = json['poster_path'];
    adult = json['adult'];
    overview = json['overview'];
    genreIds = json["genre_ids"].cast<int>();
    releaseDate = json['release_date'];
    id = json['id'];
    originalTitle = json['original_title'];
    originalLanguage = json['original_language'];
    title = json['title'];
    backdropPath = json['backdrop_path'];
    popularity = json['popularity'] / 1;
    voteCount = json['vote_count'];
    video = json['video'];
    voteAverage = json['vote_average'] / 1;
  }
  getPosterImage() {
    if (posterPath == null) {
      return const Image(
          image: NetworkImage(
              'https://image.tmdb.org/t/p/w500/sv1xJUazXeYqALzczSZ3O6nkH75.jpg'));
    } else {
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }
  }

  getBackgroundImage() {
    if (backdropPath == null) {
      return const Image(
          image: NetworkImage(
              'https://image.tmdb.org/t/p/w500/sv1xJUazXeYqALzczSZ3O6nkH75.jpg'));
    } else {
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';
    }
  }
}
