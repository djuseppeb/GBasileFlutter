import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../models/post.dart';

class PostWidget extends StatelessWidget {
  final Post postData;
  const PostWidget(this.postData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical:24, horizontal: 16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //User data
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(postData.owner.picture ?? "https://via.placeholder.com/150"),
                  ),
                  const SizedBox(width: 16),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text("${postData.owner.firstName} ${postData.owner.lastName}",
                        style: GoogleFonts.ubuntu(
                            fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
                    if (postData.publishDate != null)
                      Text(DateFormat.yMMMMd('it_IT').add_Hm().format(DateTime.parse(postData.publishDate!)),
                        style: GoogleFonts.ubuntu(fontSize: 16, color: Colors.black54)),
                  ])
                ],
              ),
              //Post data
              //Didascalia
              if(postData.text != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text((postData.text!), style: GoogleFonts.ubuntu(fontSize: 16, color: Colors.black)),
                ),

              //Immagine
              if(postData.image != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Image.network(postData.image!),
                ),

              //Lista dei tag
              if (postData.tags != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Wrap(
                    spacing: 6,
                    children:postData.tags!.map((tag) => Chip(label: Text(tag))).toList(),
                  ),
                ),

              const Divider(thickness: 2,),
              //Likes and comments
              Row(
                children: [
                  //Likes
                  Row(
                    children: [
                      Icon(Icons.thumb_up_rounded),
                      Text("${postData.likes ?? 0}", style: GoogleFonts.ubuntu(fontSize: 16, color: Colors.black))
                    ],
                  ),
                  SizedBox(width: 32),
                  //Comments
                  Row(
                    children: [
                      Icon(Icons.comment_rounded),
                      Text("Commenti", style: GoogleFonts.ubuntu(fontSize: 16, color: Colors.black))
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
