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
  String? _message;
  late TextEditingController _textEditingController;
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

  void initVariables(){
    _listComment = [];
    _skip = 0;
    _page = 0;
    _hasMoreComments = false;
    _future = _fetchComments();
  }

  Future<void> newComment() async {
    {
      bool popResult = await showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context){
            return Padding(
              padding: EdgeInsets.only(
                top: 8,
                left: 8,
                right: 8,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    autofocus: true,
                    controller: _textEditingController,
                    maxLines: 5,
                    onChanged: (value){
                      _message = _textEditingController.text;
                    },
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          onPressed: (){
                            _message = null;
                            _textEditingController.clear();
                            Navigator.of(context).pop();
                          },
                          child: const Text("Annulla")
                      ),
                      ElevatedButton(
                          onPressed: () async{
                            if(_message == null || _message!.isEmpty){
                              Navigator.of(context).pop();
                            }
                            await ApiComment.newCommentFromString(widget.postId, _message!);
                            _message = null;
                            _textEditingController.clear();
                            Navigator.of(context).pop(true);
                          },
                          child: const Text("Pubblica")
                      )
                    ],
                  )
                ],
              ),
            );
          }
      );
      if(popResult){
        setState(() {
          initVariables();
        });
      }
    }
  }


  @override
  void initState() {
    super.initState();
    initVariables();
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(title: "Commenti",),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
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
              ),
            ),

            GestureDetector(
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
                child: TextField(
                  enabled: false,
                  decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32)),
                          borderSide: BorderSide(
                            color: Colors.black54,
                          )
                      ),
                      hintText: "Lascia un commento"
                  ),
                ),
              ),
              onTap: () { newComment(); },
            )
          ],
        )
      ),
    );
  }
}
