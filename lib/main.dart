import 'package:flutter/material.dart';
import 'package:flutterarchtestapp/home_view_model.dart';
import 'package:flutterarchtestapp/status.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

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
        home: MyHomePage(
          title: "My Home Page",
        ),
      ),
    );

    return ChangeNotifierProvider<HomeViewModel>(
      create: (_) => HomeViewModel(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(
          title: "My Home Page",
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        title: Text(widget.title),
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
                      Get.toNamed("/movie-details");
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
