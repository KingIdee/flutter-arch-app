import 'package:flutter/material.dart';
import 'package:flutterarchtestapp/screens/movie_details_page.dart';
import 'package:flutterarchtestapp/viewmodels/home_view_model.dart';
import 'package:flutterarchtestapp/models/status.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'screens/movie_list_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => HomeViewModel())],
      child: GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MovieListPage(),
        routes: {
          '/movie-details': (context) => MovieDetailsPage(),
        },
      ),
    );

  }
}
