import 'dart:convert';

import 'package:prova_json/models/user_response.dart';
import 'package:http/http.dart' as http;

class ApiUser{
  static Future<UserResponse> getUserFromInternet() async{

    final response = await http.get(Uri.parse("https://dummyjson.com/users"));

    if (response.statusCode == 200){
      return UserResponse.fromJson(jsonDecode(response.body));
    }

    throw Exception('Errore in getUserFromInternet: ${response.statusCode} - ${response.reasonPhrase}');
  }
}