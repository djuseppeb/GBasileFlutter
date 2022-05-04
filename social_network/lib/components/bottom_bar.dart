import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_network/pages/profile.dart';

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
         IconButton(
           onPressed: () async{
             SharedPreferences sp = await SharedPreferences.getInstance();
             var userId = sp.getString('user');
             Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(userId!)));
           },
           icon: Icon(Icons.face),
         )
       ],
     ),
    );
  }
}
