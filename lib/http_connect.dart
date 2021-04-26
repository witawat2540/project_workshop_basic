import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class Connect_API {
  static String url = 'https://reqres.in/';
  static var headers = {HttpHeaders.contentTypeHeader: "application/json"};

  static Future get(String path) async {
    http.Response response =
        await http.get(Uri.parse(url + path), headers: headers);
    return response.body;
  }

  static Future<Map<String, dynamic>> post(String path, data) async {
    http.Response response = await http.post(Uri.parse(url + path), body: data);
    //print(response.statusCode);
    return jsonDecode(response.body);
  }
}
