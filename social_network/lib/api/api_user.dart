import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:social_network/models/user_response.dart';

import 'package:social_network/models/user.dart';

class ApiUser{

  static String get baseUrl => "https://dummyapi.io/data/v1";

  //Ritorna lista di tutti gli utenti
  static Future<UserResponse> getUserList({int page = 0, int limit = 20}) async{
    final response = await http.get(Uri.parse("$baseUrl/user/?page=$page&limit=$limit"), headers: {'app-id': '626fc935e000f620bdf05f17'});
    
    if (response.statusCode == 200){
      return UserResponse.fromJson(jsonDecode(response.body));
    }
    throw Exception("Errore nel ricevere gli utenti ${response.body}");
  }

  //ritorna l'utente con l'id specificato
  static Future<User> getUserById(String id) async{
    final response = await http.get(Uri.parse("$baseUrl/user/$id"), headers: {'app-id': '626fc935e000f620bdf05f17'});

    if (response.statusCode == 200){
      return User.fromJson(jsonDecode(response.body));
    }
    throw Exception("Errore nel ricevere informazioni dell'utente ${response.body}");
  }

  //Creazione nuovo utente
  static Future<User> postUser(User userData, String id) async{
    Map<String, dynamic> _jsonComment = userData.toJson();
    _jsonComment.removeWhere((key, value) => value == null);

    final http.Response response = await http.post(
        Uri.parse("$baseUrl/user/create"),
        headers: {
          'app-id': '626fc935e000f620bdf05f17',
          'Content-type' : 'application/json'
        },
        body: jsonEncode({_jsonComment})
    );

    if(response.statusCode == 200){
      return User.fromJson(jsonDecode(response.body));
    }
    throw Exception("Commento non inserito: ${response.body}");
  }

  //Modifica dati utente
  static Future<User> updateUser(User userData, String id) async{
    Map<String, dynamic> _jsonComment = userData.toJson();
    _jsonComment.removeWhere((key, value) => value == null);

    final http.Response response = await http.put(
        Uri.parse("$baseUrl/user/$id"),
        headers: {
          'app-id': '626fc935e000f620bdf05f17',
          'Content-type' : 'application/json'
        },
        body: jsonEncode({_jsonComment})
    );

    if(response.statusCode == 200){
      return User.fromJson(jsonDecode(response.body));
    }
    throw Exception("Commento non inserito: ${response.body}");
  }
}