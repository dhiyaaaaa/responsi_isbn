class Isbn {
  int? id;
  String? isbn_code;
  String? format;
  int? print_length;

  Isbn({this.id, this.isbn_code, this.format, this.print_length});

  factory Isbn.fromJson(Map<String, dynamic> obj) {
    return Isbn(
      id: obj['id'],
      isbn_code: obj['isbn_code'],
      format: obj['format'],
      print_length: obj['print_length']
      );
    }
}
