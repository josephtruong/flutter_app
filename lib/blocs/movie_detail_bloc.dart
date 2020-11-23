import 'dart:async';
import 'file:///D:/Android/flutter_app/flutter_app/lib/model/movie_response.dart';
import 'package:flutter_app/model/movie.dart';
import 'package:flutter_app/networking/ApiResponse.dart';
import 'package:flutter_app/networking/MovieDetailRepository.dart';

class MovieDetailBloc {
  MovieDetailRepository _movieDetailRepository;
  StreamController _movieDetailController;

  StreamSink<ApiResponse<Movie>> get movieDetailSink =>
      _movieDetailController.sink;

  Stream<ApiResponse<Movie>> get movieDetailStream =>
      _movieDetailController.stream;

  MovieDetailBloc() {
    _movieDetailController = StreamController<ApiResponse<Movie>>();
    _movieDetailRepository = MovieDetailRepository();
  }

  fetchMovieDetail(int selectedMovie) async {
    movieDetailSink.add(ApiResponse.loading('Fetching details'));
    try {
      Movie movie =
          await _movieDetailRepository.fetchMovieDetail(selectedMovie);
      movieDetailSink.add(ApiResponse.completed(movie));
    } catch (e) {
      movieDetailSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _movieDetailController?.close();
  }
}
