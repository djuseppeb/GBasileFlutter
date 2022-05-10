import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_network/models/comment.dart';
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

  //Aggiunta di un commento
  //Metodo 1
  static Future<Comment> newCommentFromString(String postId, String message) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? userId = sp.getString("user");

    // Se l'utente non è loggato fermalo
    if(userId == null){
      throw Exception("Impossibile pubblicare un commento, effettuare il login");
    }

    final http.Response response = await http.post(
      Uri.parse("$baseUrl/comment/create"),
      headers: {
        'app-id': '626fc935e000f620bdf05f17',
        'Content-type' : 'application/json'
      },
      body: jsonEncode({
          'owner' : userId,
          'post' : postId,
          'message' : message
        })
    );

    if(response.statusCode == 200){
      return Comment.fromJson(jsonDecode(response.body));
    }
    throw Exception("Commento non inserito: ${response.body}");
  }

  //Aggiunta di un commento
  static Future<Comment> newCommentFromObject(Comment commento) async{
    Map<String, dynamic> _jsonComment = commento.toJson();
    _jsonComment.removeWhere((key, value) => value == null);

    final http.Response response = await http.post(
      Uri.parse("$baseUrl/comment/create"),
      headers: {
        'app-id': '626fc935e000f620bdf05f17',
        'Content-type' : 'application/json'
      },
      body: jsonEncode({_jsonComment})
    );

    if(response.statusCode == 200){
      return Comment.fromJson(jsonDecode(response.body));
    }
    throw Exception("Commento non inserito: ${response.body}");
  }



  //Eliminazione commento
  static Future<bool> deleteComment(String id) async{

    final http.Response response = await http.delete(
        Uri.parse("$baseUrl/comment/$id"),
        headers: {
          'app-id': '626fc935e000f620bdf05f17',
        },
    );

    if (response.statusCode == 200){
      return true;
    }
    throw Exception("Errore nell'eliminazione del commento: ${response.body}");
  }
}