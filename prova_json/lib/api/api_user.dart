import 'dart:convert';

import 'package:prova_json/models/user_response.dart';
import 'package:http/http.dart' as http;

class ApiUser{
  static Future<UserResponse> getUserFromInternet({int skip = 0}) async{

    final response = await http.get(Uri.parse("https://dummyjson.com/users?skip=$skip"));

    if (response.statusCode == 200){
      return UserResponse.fromJson(jsonDecode(response.body));
    }

    throw Exception('Errore in getUserFromInternet: ${response.statusCode} - ${response.reasonPhrase}');
  }
}