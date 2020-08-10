import 'package:dio/dio.dart';

class API {
  Dio _dio; // TODO: Set base URL in this options

  API() {
    _dio = Dio();

    var tokenDio = new Dio(); //Create a new instance to request the token.
    tokenDio.options = _dio.options;

//    _dio.interceptors.add(_tokenInterceptor(_dio, tokenDio));

    // TODO: DO this only in debug build
//    _dio.interceptors.add(LogInterceptor(responseBody: false));
  }

  _tokenInterceptor(Dio defaultDio, Dio tokenDio) {
    return InterceptorsWrapper(onRequest: (Options options) async {
      // If no token, request token firstly and lock this interceptor
      // to prevent other request enter this interceptor.
      defaultDio.interceptors.requestLock.lock();
      // We use a new Dio(to avoid dead lock) instance to request token.
      Response response = await tokenDio.get('/token');
      //Set the token to headers
      options.headers['token'] = response.data['data']['token'];
      defaultDio.interceptors.requestLock.unlock();
      return options; //continue
    });
  }

  Future<Response> fetchPopularMovies() async {
    return await _dio.get(
        'https://api.themoviedb.org/3/movie/popular?api_key=78672b9eec5df84f1a4f9ae81fa31d59');
  }
}
