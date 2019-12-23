import 'dart:convert';

import 'package:crypto/crypto.dart';

class APIUrlBuilder {
  final String _publicKey = "5dc884e310f0f480bf8eab0e05bccc1d";
  final String _privateKey = "c626d0e803d5a75e2a074ca36abba3a8e3f4c2b4";

  final String _baseUrl = "http://gateway.marvel.com/v1/public/";

  String _generateHash(String timestamp) =>
      md5.convert(utf8.encode(timestamp + _privateKey + _publicKey)).toString();

  String generateUrl(String path, int offset, {String queryParams = ""}) {
    final String timestamp = DateTime.now().toIso8601String();
    return "$_baseUrl$path?apikey=$_publicKey&hash=${_generateHash(timestamp)}&ts=$timestamp&offset=$offset&$queryParams";
  }
}
