
import 'movie.dart';

class MovieResponse{
   int page;
   int totalPages;
   int totalResults;
   List<Movie> results;

   MovieResponse({this.page, this.totalPages, this.totalResults, this.results});
   MovieResponse.fromJson(Map<String, dynamic> js){
      page = js['page'];
      totalResults = js['total_results'];
      if (js['results'] != null){
         results = new List<Movie>();
         js['results'].forEach((v){
            results.add(new Movie.fromJson(v));
         });
      }
   }
}
