import 'package:flutter/material.dart';
import 'package:flutterarchtestapp/home_view_model.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (_) => HomeViewModel(),
      child:MaterialApp(
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
    _viewModel = Provider.of<HomeViewModel>(context,listen: false);
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),

            Consumer<HomeViewModel>(builder: (context, _viewModel, child) {
              return Text('${_viewModel.getStatus().toString()}');
            })

//              FutureBuilder(
//                future: _counter.getData(),
//                builder: (BuildContext context, AsyncSnapshot snapshot) {
//                  if (snapshot.hasData) {
//                    return ListView.builder(
//                      itemCount: snapshot.data.length,
//                      itemBuilder: (context, index) {
//                        return ListTile(
//                            title: Text(snapshot.data[index].title));
//                      },
//                    );
//                  } else if (snapshot.hasError) {
//                    return Text("${snapshot.error}");
//                  }
//                  return Center(
//                    child: CircularProgressIndicator(),
//                  );
//                },
//              )
          ],
        ),
      ),
    );
  }
}
