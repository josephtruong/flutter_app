import 'package:flutter_app/model/movie_response.dart';
import 'package:flutter_app/model/movie.dart';
import 'package:flutter_app/networking/ApiBaseHelper.dart';
import '../apiKey.dart';

class MovieRepository{
   final String _apiKey = apiKey;
   ApiBaseHelper _helper = ApiBaseHelper();

   Future<List<Movie>> fetchMovieList() async {
      final response = await _helper.get('movie/popular?api_key=$_apiKey');
      return MovieResponse.fromJson(response).results;
   }

}