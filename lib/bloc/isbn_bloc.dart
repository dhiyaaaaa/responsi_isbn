import 'dart:convert';
import 'package:buku_flutter/helpers/api.dart';
import 'package:buku_flutter/helpers/api_url.dart';
import 'package:buku_flutter/model/isbn.dart';

class IsbnBloc {
  static Future<List<Isbn>> ambilDaftarIsbn() async {
    String apiUrl = ApiUrl.listIsbn;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listIsbn = (jsonObj as Map<String, dynamic>)['data'];
    List<Isbn> daftarIsbn = [];

    for (int i = 0; i < listIsbn.length; i++) {
      daftarIsbn.add(Isbn.fromJson(listIsbn[i]));
    }
    return daftarIsbn;
  }

  static Future tambahIsbn({Isbn? isbn}) async {
    String apiUrl = ApiUrl.createIsbn;

    var body = {
      "isbn_code": isbn?.isbn_code,
      "format": isbn?.format,
      "print_length": isbn?.print_length
    };
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future perbaruiIsbn({required Isbn isbn}) async {
    String apiUrl = ApiUrl.updateIsbn(isbn.id!);
    print(apiUrl);

    var body = {
      "isbn_code": isbn.isbn_code,
      "format": isbn.format,
      "print_length": isbn.print_length
    };
    print("Body : $body");
    var response = await Api().put(apiUrl, body); // Panggil dengan body
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> hapusIsbn({int? id}) async {
    String apiUrl = ApiUrl.deleteIsbn(id!);

    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
