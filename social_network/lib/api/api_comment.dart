import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:social_network/models/comment_response.dart';

class ApiComment{

  static String get baseUrl => "https://dummyapi.io/data/v1";

  //Ritorna lista di tutti i commenti
  static Future<CommentResponse> getCommentList({int page = 0, int limit = 20}) async{
    final response = await http.get(Uri.parse("$baseUrl/comment/?page=$page&limit=$limit"), headers: {'app-id': '626fc935e000f620bdf05f17'});

    if (response.statusCode == 200){
      return CommentResponse.fromJson(jsonDecode(response.body));
    }
    throw Exception("Errore nel ricevere i commenti ${response.body}");
  }

  //Ritorna la lista dei commenti di un post
  static Future<CommentResponse> getCommentByPost(String id, {int page = 0, int limit = 20}) async{
    final response = await http.get(Uri.parse("$baseUrl/post/$id/comment/?page=$page&limit=$limit"), headers: {'app-id': '626fc935e000f620bdf05f17'});

    if (response.statusCode == 200){
      return CommentResponse.fromJson(jsonDecode(response.body));
    }
    throw Exception("Errore nel ricevere i commenti ${response.body}");
  }

  //Ritorna la lista di tutti i commenti di un utente
  static Future<CommentResponse> getCommentByUser(String id, {int page = 0, int limit = 20}) async{
    final response = await http.get(Uri.parse("$baseUrl/user/$id/comment/?page=$page&limit=$limit"), headers: {'app-id': '626fc935e000f620bdf05f17'});

    if (response.statusCode == 200){
      return CommentResponse.fromJson(jsonDecode(response.body));
    }
    throw Exception("Errore nel ricevere i commenti ${response.body}");
  }
}