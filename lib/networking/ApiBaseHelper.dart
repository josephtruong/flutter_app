import 'dart:convert';
import 'dart:io';
import 'package:flutter_app/networking/AppException.dart';
import 'package:http/http.dart' as http;

class ApiBaseHelper {
  final String _baseURL = "http://api.themoviedb.org/3/";

  Future<dynamic> get(String url) async {
    print('Api get $url');
    var responseJson;
    try {
       final response = await http.get(_baseURL + url);
       responseJson = _returnResponse(response);
    } on SocketException {
        print('No net');
        throw FetchDataException('No internet connection');
    }
    print('api get recieved!');
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400: throw BadRequestException(response.body.toString());
      case 401:
      case 403: throw UnauthorisedException(response.body.toString());
      case 500:
      default:
          throw FetchDataException('Error occured while Communication with Server with StatusCode ${response.statusCode}');
    }
  }

}