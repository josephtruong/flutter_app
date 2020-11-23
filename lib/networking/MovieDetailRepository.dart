import 'package:flutter_app/apiKey.dart';
import 'package:flutter_app/model/movie.dart';
import 'file:///D:/Android/flutter_app/flutter_app/lib/model/movie_response.dart';

import 'ApiBaseHelper.dart';

class MovieDetailRepository{
  final String _apiKey = apiKey;
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<Movie> fetchMovieDetail(int selectedMovie) async {
    final response = await _helper.get('movie/$selectedMovie?api_key=$_apiKey');
    return Movie.fromJson(response);
  }

}
