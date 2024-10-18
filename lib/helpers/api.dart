import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:buku_flutter/helpers/user_info.dart';
import 'app_exception.dart';

class Api {
  Future<dynamic> post(String url, Map<String, dynamic> data) async {
    var token = await _getToken();
    var responseJson;
    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } catch (e) {
      throw FetchDataException('An error occurred: $e');
    }
    return responseJson;
  }

  Future<dynamic> get(String url) async {
    var token = await _getToken();
    var responseJson;
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } catch (e) {
      throw FetchDataException('An error occurred: $e');
    }
    return responseJson;
  }

  Future<dynamic> put(String url, Map<String, dynamic> data) async {
    var token = await _getToken();
    var responseJson;
    try {
      final response = await http.put(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } catch (e) {
      throw FetchDataException('An error occurred: $e');
    }
    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    var token = await _getToken();
    var responseJson;
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } catch (e) {
      throw FetchDataException('An error occurred: $e');
    }
    return responseJson;
  }

  Future<String?> _getToken() async {
    return await UserInfo().getToken();
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response; // Kembalikan respons yang utuh
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 422:
        throw InvalidInputException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
          'Error occurred while communicating with Server: ${response.statusCode} - ${response.body}',
        );
    }
  }
}
