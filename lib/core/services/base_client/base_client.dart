import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'app_exceptions.dart';

class BaseClient {
  static const int timeOutDuration = 20;
  //GET
  Future<dynamic> get(String baseUrl, String api) async {
    var uri = Uri.parse(baseUrl + api);
    try {
      var response =
          await http.get(uri).timeout(const Duration(seconds: timeOutDuration));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  //POST
  Future<dynamic> post(String baseUrl, String api, dynamic payloadObj) async {
    var uri = Uri.parse(baseUrl + api);
    var payload = json.encode(payloadObj);
    try {
      var response = await http
          .post(uri, body: payload)
          .timeout(const Duration(seconds: timeOutDuration));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
        'API not responded in time',
        uri.toString(),
      );
    }
  }

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;

      case 201:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;

      case 400:
        throw BadRequestException(
          utf8.decode(response.bodyBytes),
          response.request?.url.toString(),
          message: '',
          url: '',
        );

      case 401:
        throw UnAuthorizedException(
          utf8.decode(response.bodyBytes),
          response.request!.url.toString(),
        );

      case 403:
        throw UnAuthorizedException(
          utf8.decode(response.bodyBytes),
          response.request!.url.toString(),
        );

      case 404:
        throw throw InternalServerErrorException(
          utf8.decode(response.bodyBytes),
          response.request!.url.toString(),
        );

      case 500:
        throw ServerException(
          utf8.decode(response.bodyBytes),
          response.request!.url.toString(),
        );

      default:
        throw FetchDataException(
          'Error occured with code : ${response.statusCode}',
          response.request!.url.toString(),
        );
    }
  }
}
