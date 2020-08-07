class MovieList {
  final List<MovieItem> movieList;

  MovieList({this.movieList});

  factory MovieList.fromJson(List parsedJson) {
    var list = parsedJson;
    List<MovieItem> newList = list.map((i) => MovieItem.fromJson(i)).toList();

    return MovieList(movieList: newList);
  }
}

class MovieItem {
  var id;
  String title;

  MovieItem({this.id, this.title});

  factory MovieItem.fromJson(Map<String, dynamic> json) =>
      MovieItem(id: json['id'], title: json['title'] as String);

  Map<String, dynamic> toJson(MovieItem instance) => <String, dynamic>{
        'id': instance.id,
        'title': instance.title,
      };
}
