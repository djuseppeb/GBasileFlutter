import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:social_network/models/tag_response.dart';

class ApiUser{

  static String get baseUrl => "https://dummyapi.io/data/v1";

  //Ritorna lista di tutti i tag
  static Future<TagResponse> getTagList({int page = 0, int limit = 20}) async{
    final response = await http.get(Uri.parse("$baseUrl/tag/?page=$page&limit=$limit"), headers: {'app-id': '626fc935e000f620bdf05f17'});

    if (response.statusCode == 200){
      return TagResponse.fromJson(jsonDecode(response.body));
    }
    throw Exception("Errore nel ricevere i tag ${response.body}");
  }
}