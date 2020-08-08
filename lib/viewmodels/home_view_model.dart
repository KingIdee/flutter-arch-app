import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutterarchtestapp/network/api.dart';
import 'package:flutterarchtestapp/models/status.dart';

import '../models/movie.dart';

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

  void getData() async {
    _status = Status.LOADING;
    notifyListeners();

    try {
      var response = await _api.fetchPopularMovies();
      if (response.statusCode == HttpStatus.ok) {
        _status = Status.SUCCESSFUL;
        _movieList =
            MovieList.fromJson(json.decode(response.body)["results"]).movieList;
        notifyListeners();
      } else {
        _status = Status.FAILED;
        _errorMessage = json.decode(response.body)['message'];
        notifyListeners();
      }
    } catch (e) {
      _status = Status.FAILED;
      _errorMessage = "An unknown error occurred";
      notifyListeners();
    }
  }
}
