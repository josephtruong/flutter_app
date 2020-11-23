import 'dart:async';
import 'package:flutter_app/model/movie.dart';
import 'package:flutter_app/networking/ApiResponse.dart';
import 'package:flutter_app/networking/MovieRepository.dart';

class MovieBloc {
   MovieRepository _movieRepository;
   StreamController _movieListController;

   StreamSink<ApiResponse<List<Movie>>> get movieListSink => _movieListController.sink;
   Stream<ApiResponse<List<Movie>>> get movieListStream => _movieListController.stream;

   MovieBloc(){
      _movieListController = StreamController<ApiResponse<List<Movie>>>();
      _movieRepository = MovieRepository();
   }

   fetchMovieList() async {
      movieListSink.add(ApiResponse.loading('Fetching movie'));
      try{
         List<Movie> movies = await _movieRepository.fetchMovieList();
         movieListSink.add(ApiResponse.completed(movies));
      } catch (e) {
          movieListSink.add(ApiResponse.error(e.toString()));
          print(e);
      }
   }

   dispose() {
      _movieListController?.close();
   }
}