import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:social_network/models/comment.dart';

class CommentCard extends StatelessWidget {
  final Comment commentData;
  const CommentCard(this.commentData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 32,
              backgroundImage: NetworkImage(commentData.owner.picture ?? "https://via.placeholder.com/150"),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${commentData.owner.firstName} ${commentData.owner.lastName}", style: GoogleFonts.ubuntu(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
                    Text(commentData.message, style: GoogleFonts.ubuntu(fontSize: 16, color: Colors.black,)),
                    Text(DateFormat.yMMMMd('it_IT').add_Hm().format(DateTime.parse(commentData.publishDate)), style: GoogleFonts.ubuntu(fontSize: 14, color: Colors.black54,))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
