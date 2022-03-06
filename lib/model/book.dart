class Book {
  final int id;
  final String original_title;
  final String overview;
  final String backdrop_path;
  final String release_date;

  const Book(
      {required this.id,
      required this.overview,
      required this.original_title,
      required this.backdrop_path,
      required this.release_date});

  factory Book.fromJson(Map<String, dynamic> json) => Book(
      id: json['id'],
      overview: json['overview'],
      original_title: json['original_title'],
      backdrop_path: json['backdrop_path'],
      release_date: json['release_date']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'original_title': original_title,
        'overview': overview,
        'backdrop_path': backdrop_path,
        'release_date': release_date
      };
}
