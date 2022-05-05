import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_network/components/top_bar.dart';
import 'package:social_network/models/comment.dart';
import 'package:social_network/models/comment_response.dart';

import '../api/api_comment.dart';
import '../components/comment_card.dart';

class PostComments extends StatefulWidget {
  final String postId;
  const PostComments(this.postId, {Key? key}) : super(key: key);

  @override
  State<PostComments> createState() => _PostCommentsState();
}

class _PostCommentsState extends State<PostComments> {
  late List<Comment> _listComment;
  late int _skip;
  late int _page;
  late bool _hasMoreComments;
  late Future<List<Comment>> _future;

  Future<List<Comment>> _fetchComments() async{
    final CommentResponse result = await ApiComment.getCommentByPost(widget.postId, page: _page);
    setState(() {
      _skip = _skip + result.limit;
      _hasMoreComments = (result.total - _skip) > 0;
      _page++;
      _listComment = _listComment + result.data;
    });
    return _listComment;
  }

  @override
  void initState() {
    _listComment = [];
    _skip = 0;
    _page = 0;
    _hasMoreComments = false;
    _future = _fetchComments();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(title: "Commenti",),
      body: SafeArea(
        child: FutureBuilder(
          future: _future,
          builder: (context, snapshot){
            if(snapshot.data!=null && snapshot.data is List<Comment>){
              final _listCommentiVisualizzati = (snapshot.data as List<Comment>);

              if(_listCommentiVisualizzati.isEmpty){
                return Center(
                    child: Text("Ancora nessun commento :(", style: GoogleFonts.ubuntu(fontSize: 24, color: Colors.black54,)));
              }

              return ListView.builder(
                itemCount: _listCommentiVisualizzati.length + (_hasMoreComments ? 1 : 0),
                itemBuilder: (context, index){

                  if(index == _listCommentiVisualizzati.length){
                    // chiamiamo di nuovo la funzione fetchPost per aggiungere un'altra pagina di post alla list
                    _future = _fetchComments();
                    // nel frattempo che carico, mostro un simbolo di attesa
                    return const Center(child: CircularProgressIndicator(),);
                  }

                  return CommentCard(_listCommentiVisualizzati[index]);
                }
              );
            }

            if (snapshot.hasError){
              return Center(
                  child: Text("Errore nel caricamento: ${snapshot.error}", style: const TextStyle(fontSize: 24),)
              );
            }

            return const Center(
                child: CircularProgressIndicator()
            );

          },
        )
      ),
    );
  }
}
