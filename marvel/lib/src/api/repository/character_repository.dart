import 'dart:convert';

import 'package:marvel/src/api/api_url_builder.dart';
import 'package:http/http.dart' as http;

import 'character.dart';

class CharacterRepository {
  final _client = http.Client();
  final urlBuilder = APIUrlBuilder();

  Future<Iterable<Character>> fetchCharacters(int offset) async {
    final url = urlBuilder.generateUrl("/characters", offset);
    final response = await _client.get(url);
    final Map<String, dynamic> jsonData = json.decode(response.body)['data'];
    final Iterable<dynamic> results =
        jsonData?.containsKey('results') ?? false ? jsonData['results'] : [];
    return results.map((data) => Character.fromJson(data)).toList();
  }
}
