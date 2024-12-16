import 'dart:convert';
import 'dart:io';

import 'package:assesment_flutter/utils/api_endpoint.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  static const String baseUrl = 'https://run.mocky.io/v3/';

  final Map<String, String> _headers = {'deviceType': 'Mob'};
  final Map<String, String> _headers2 = {'Content-Type': 'application/json'};


  static final _options = BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(milliseconds: connectionTimeout),
    receiveTimeout: const Duration(milliseconds: receiveTimeout),
    responseType: ResponseType.json,
  );
  static const int receiveTimeout = 30000;
  static const int connectionTimeout = 30000;
  final Dio _dio = Dio(_options)..interceptors.add(LogInterceptor());

  /*//get api by http
  Future<http.Response?> blockDataDownload() async {
    try {
      var url = Uri.parse(baseUrl + ApiEndpoint.blockData);
      debugPrint("Url : $url");
      http.Response response = await http.get(
        url,
        headers: _headers2,
      );
      debugPrint("Response : ${response.body}");
      return response;
    } catch (e) {
      debugPrint('Exception $e');
      return null;
    }
  }*/

  //get api by dio
  Future<Response?> blockDataDownload() async {
    try {
      Response response = await _dio.get(
        baseUrl + ApiEndpoint.blockData,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        // data: {"":""},
      );
      return response;
    } catch (e) {
      debugPrint("ex>>>>>>>>>>>>$e");
      return null;
    }
  }
}