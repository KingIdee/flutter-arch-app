import 'dart:convert';

import 'package:dio/dio.dart';
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
      if (response.statusCode == 200) {
        _status = Status.SUCCESSFUL;
        _movieList = MovieList.fromJson(response.data['results']).movieList;
        notifyListeners();
      }
    } on DioError catch (e) {
      if (e.response != null) {
        _errorMessage = e.response.data['status_message'];
      } else {
        _errorMessage = 'An unknown error occurred';
      }
      _status = Status.FAILED;
      notifyListeners();
    }
  }
}
