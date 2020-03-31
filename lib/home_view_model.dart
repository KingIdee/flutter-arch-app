import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterarchtestapp/api.dart';
import 'package:flutterarchtestapp/status.dart';

import 'movie.dart';

class HomeViewModel with ChangeNotifier {
  var _api = API(); // Use dependency injection for this ideally;
  List<MovieItem> _movieList;
  Status _status = Status.LOADING;
  String _errorMessage;

  HomeViewModel();

  List<MovieItem> getMovieList() {
    return _movieList;
  }

  String getErrorMessage() {
    return _errorMessage;
  }

  Status getStatus() {
    return _status;
  }

  void getData() {
    _status = Status.LOADING;
    notifyListeners();
    _api.fetchPopularMovies().then((response) {
      if (response.statusCode >= 200 && response.statusCode < 300) {
        _status = Status.SUCCESSFUL;
        _movieList =
            MovieList.fromJson(json.decode(response.body)["results"]).movieList;
        print(_movieList.length);
        notifyListeners();
      } else {
        _status = Status.FAILED;
        _errorMessage = json.decode(response.body)['message'];
        notifyListeners();
      }
    }).catchError((error) {
      _status = Status.FAILED;
      _errorMessage = "An unknown error occurred";
      notifyListeners();
    });
  }
}
