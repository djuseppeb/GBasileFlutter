import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceAround,
       children: [
         IconButton(
             onPressed: (){
               Navigator.of(context).pushNamed("/home");
             },
             icon: Icon(Icons.home),
         ),
         IconButton(
           onPressed: (){
             Navigator.of(context).pushNamed("/home");
           },
           icon: Icon(Icons.search),
         ),
         IconButton(
           onPressed: (){
             Navigator.of(context).pushNamed("/home");
           },
           icon: Icon(Icons.people),
         ),
         CircleAvatar(
           radius: 16,
           backgroundImage: NetworkImage(
               "https://randomuser.me/api/portraits/women/58.jpg"),
         )
       ],
     ),
    );
  }
}
