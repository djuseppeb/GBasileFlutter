import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostWidget extends StatelessWidget {
  final String? postText;
  final String? imgUrl;
  const PostWidget({Key? key, this.postText, this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Card(
      elevation: 6,
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
                  backgroundImage: NetworkImage(
                      "https://randomuser.me/api/portraits/women/58.jpg"),
                ),
                SizedBox(width: 16),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("Sara Anderson",
                      style: GoogleFonts.ubuntu(
                          fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
                  Text("03-05-2022",
                      style: GoogleFonts.ubuntu(
                          fontSize: 16, color: Colors.black54)),
                ])
              ],
            ),
            //Post data
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: (postText!=null) ? Text((postText!), style: GoogleFonts.ubuntu(fontSize: 16, color: Colors.black)) : Container(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Icon(Icons.sell_rounded, color: Colors.blueAccent.shade400, size: 16,),
                  Text("animal, dog, golden retriever", style: GoogleFonts.ubuntu(fontSize: 16, color: Colors.blueAccent.shade400)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: (imgUrl!=null) ? Image.network(imgUrl!) : Container(),
            ),
            const Divider(thickness: 2,),
            //Likes and comments
            Row(
              children: [
                //Likes
                Row(
                  children: [
                    Icon(Icons.thumb_up_rounded),
                    Text("73", style: GoogleFonts.ubuntu(fontSize: 16, color: Colors.black))
                  ],
                ),
                SizedBox(width: 32),
                //Comments
                Row(
                  children: [
                    Icon(Icons.comment_rounded),
                    Text("12", style: GoogleFonts.ubuntu(fontSize: 16, color: Colors.black))
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
