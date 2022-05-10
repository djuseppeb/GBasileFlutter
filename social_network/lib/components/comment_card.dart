import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_network/models/comment.dart';
import 'package:social_network/models/post.dart';

import '../api/api_comment.dart';

class CommentCard extends StatefulWidget {
  final Comment commentData;
  final Post postData;
  const CommentCard(this.commentData, this.postData, {Key? key}) : super(key: key);

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  late bool _deleted;

  void deleteComment() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Vuoi davvero eliminare il commento?"),
        content: const Text("Questa azione non è reversibile, il commento verrà perduto per sempre!"),
        actions: [
          TextButton(
              onPressed: () async{
                Navigator.of(context).pop();
                if(widget.commentData.id != null) {
                  await ApiComment.deleteComment(widget.commentData.id!);
                  setState(() {
                    _deleted = true;
                  });
                }
              },
              child: const Text("Sì!")
          ),
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("No")
          ),

        ],
      ),
      barrierDismissible: false,
    );
  }

  @override
  void initState() {
    super.initState();
    _deleted = false;
  }

  @override
  Widget build(BuildContext context) {

    return Visibility(
      visible: !_deleted,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 32,
                backgroundImage: NetworkImage(widget.commentData.owner.picture ?? "https://via.placeholder.com/150"),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${widget.commentData.owner.firstName} ${widget.commentData.owner.lastName}", style: GoogleFonts.ubuntu(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
                      Text(widget.commentData.message, style: GoogleFonts.ubuntu(fontSize: 16, color: Colors.black,)),
                      Text(DateFormat.yMMMMd('it_IT').add_Hm().format(DateTime.parse(widget.commentData.publishDate)), style: GoogleFonts.ubuntu(fontSize: 14, color: Colors.black54,))
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  SharedPreferences sp = await SharedPreferences.getInstance();
                  String? userId = sp.getString("user");

                  if(userId == widget.commentData.owner.id || userId == widget.postData.owner?.id){
                    deleteComment();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
