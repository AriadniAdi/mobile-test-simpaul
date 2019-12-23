import 'package:meta/meta.dart';

class Character {
  Character._({
    @required this.image,
    @required this.name,
    @required this.bookmarked,
    @required this.id,
    this.description,
  })  : assert(image != null),
        assert(name != null),
        assert(id != null),
        assert(bookmarked != null);

  factory Character.fromJson(Map<String, dynamic> data) => Character._(
        image: Thumbnail.fromJson(data['thumbnail']),
        name: data['name'],
        description: data['description'],
        bookmarked: false,
        id: data['id'],
      );

  final String name;
  final Thumbnail image;
  final String description;
  final bool bookmarked;
  final int id;

  Character copyWith({
    String name,
    Thumbnail image,
    String description,
    bool bookmarked,
    int id,
  }) =>
      Character._(
        image: image ?? this.image,
        name: name ?? this.name,
        description: description ?? this.description,
        bookmarked: bookmarked ?? this.bookmarked,
        id: id ?? this.id,
      );
}

class Thumbnail {
  const Thumbnail._(this.url, this.fileExtension);
  factory Thumbnail.fromJson(Map<String, dynamic> data) =>
      Thumbnail._(data['path'], data['extension']);
  final String fileExtension;
  final String url;

  String get xlarge => '$url/portrait_xlarge.$fileExtension';
  String get small => '$url/portrait_small.$fileExtension';
  String get medium => '$url/portrait_medium.$fileExtension';
  String get fantastic => '$url/portrait_fantastic.$fileExtension';
  String get uncanny => '$url/portrait_uncanny.$fileExtension';
  String get incredible => '$url/portrait_incredible.$fileExtension';
}
