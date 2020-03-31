
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


class API {

  Future<Response> fetchPopularMovies() async {
    String URL = "https://api.themoviedb.org/3/movie/popular?api_key=78672b9eec5df84f1a4f9ae81fa31d59";
    Map<String, String> headers = new Map();
    return await http.get(URL, headers: headers);
  }

}