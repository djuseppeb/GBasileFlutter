import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:social_network/models/post.dart';
import 'package:social_network/models/post_response.dart';

class ApiPost{

  static String get baseUrl => "https://dummyapi.io/data/v1";

  //Ritorna lista di tutti i post
  static Future<PostResponse> getPostList({int page = 0, int limit = 20}) async{
    final response = await http.get(Uri.parse("$baseUrl/post/?page=$page&limit=$limit"), headers: {'app-id': '626fc935e000f620bdf05f17'});

    if (response.statusCode == 200){
      return PostResponse.fromJson(jsonDecode(response.body));
    }
    throw Exception("Errore nel ricevere i post ${response.body}");
  }

  //ritorna il post con l'id specificato
  static Future<Post> getPostById(String id) async{
    final response = await http.get(Uri.parse("$baseUrl/post/$id"), headers: {'app-id': '626fc935e000f620bdf05f17'});

    if (response.statusCode == 200){
      return Post.fromJson(jsonDecode(response.body));
    }
    throw Exception("Errore nel trovare il post ${response.body}");
  }

  //ritorna tutti i post di un dato utente
  static Future<PostResponse> getPostByUser(String id, {int page = 0, int limit = 20}) async{
    final response = await http.get(Uri.parse("$baseUrl/user/$id/post/?page=$page&limit=$limit"), headers: {'app-id': '626fc935e000f620bdf05f17'});

    if (response.statusCode == 200){
      return PostResponse.fromJson(jsonDecode(response.body));
    }
    throw Exception("Errore nel ricevere i post ${response.body}");
  }

  //ritorna tutti i post con un determinato tag
  static Future<PostResponse> getPostByTag(String id, {int page = 0, int limit = 20}) async{
    final response = await http.get(Uri.parse("$baseUrl/tag/$id/post/?page=$page&limit=$limit"), headers: {'app-id': '626fc935e000f620bdf05f17'});

    if (response.statusCode == 200){
      return PostResponse.fromJson(jsonDecode(response.body));
    }
    throw Exception("Errore nel ricevere i post ${response.body}");
  }

  //Creazione di un post
  static Future<Post> postCreatePost(Post post) async{
    Map<String, dynamic> _jsonPost = post.toJson();
    _jsonPost.removeWhere((key, value) => value == null);

    final http.Response response = await http.post(
        Uri.parse("$baseUrl/post/create"),
        headers: {
          'app-id': '626fc935e000f620bdf05f17',
          'Content-type' : 'application/json'
        },
        body: jsonEncode({_jsonPost})
    );

    if(response.statusCode == 200){
      return Post.fromJson(jsonDecode(response.body));
    }
    throw Exception("Pubblicazione fallita: ${response.body}");
  }

  //Modifica di un post
  static Future<Post> updatePost(String id, Post postData) async{
    Map<String, dynamic> _jsonPost = postData.toJson();
    _jsonPost.removeWhere((key, value) => value == null);

    final http.Response response = await http.put(
        Uri.parse("$baseUrl/post/$id"),
        headers: {
          'app-id': '626fc935e000f620bdf05f17',
          'Content-type' : 'application/json'
        },
        body: jsonEncode({_jsonPost})
    );

    if(response.statusCode == 200){
      return Post.fromJson(jsonDecode(response.body));
    }
    throw Exception("Modifica fallita: ${response.body}");
  }

  //Cancellazione di un post
  static Future<Post> deleteComment(String id) async{

    final http.Response response = await http.delete(
      Uri.parse("$baseUrl/post/$id"),
      headers: {
        'app-id': '626fc935e000f620bdf05f17',
      },
    );

    if (response.statusCode == 200){
      return Post.fromJson(jsonDecode(response.body));
    }
    throw Exception("Errore nell'eliminazione del post: ${response.body}");
  }
}