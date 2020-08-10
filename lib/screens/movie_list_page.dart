import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../viewmodels/home_view_model.dart';
import '../models/status.dart';

class MovieListPage extends StatefulWidget {
  MovieListPage({Key key}) : super(key: key);

  @override
  _MovieListPageState createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = Provider.of<HomeViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.getData();
    });
  }

  @override
  Widget build(BuildContext context) {
//    final _counter = Provider.of<Counter>(context);
    // Consumer<HomeViewModel>(builder: (context, _viewModel, child)
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: Container(
        child: Consumer<HomeViewModel>(builder: (context, _viewModel, child) {
          if (_viewModel.getStatus() == Status.FAILED) {
            return Center(child: Text(_viewModel.getErrorMessage()));
          } else if (_viewModel.getStatus() == Status.SUCCESSFUL) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: _viewModel.getMovieList().length,
              itemBuilder: (context, index) {
                return ListTile(
                    onTap: () {
                      Get.toNamed('/movie-details');
                    },
                    title: Text(_viewModel.getMovieList()[index].title));
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }
}
