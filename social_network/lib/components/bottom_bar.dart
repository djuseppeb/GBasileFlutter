import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_network/pages/profile.dart';

class BottomBar extends StatelessWidget {
  final String currentPage;
  const BottomBar({Key? key, required this.currentPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceAround,
       children: [
         IconButton(
             onPressed: (){
               if (currentPage != "home") {
                 Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
               }
             },
             icon: Icon(Icons.home, color: (currentPage == "home") ? Colors.deepPurpleAccent.shade200 : Colors.black87),
         ),
         IconButton(
           onPressed: (){
             Navigator.of(context).pushNamed("/search");
           },
           icon: Icon(Icons.search, color: (currentPage == "search") ? Colors.deepPurpleAccent.shade200 : Colors.black87),
         ),
         IconButton(
           onPressed: () async{
             if (currentPage != "profile"){
               SharedPreferences sp = await SharedPreferences.getInstance();
               var userId = sp.getString('user');
               Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(userId!)));
             }
           },
           icon: Icon(Icons.face, color: (currentPage == "profile") ? Colors.deepPurpleAccent.shade200 : Colors.black87),
         )
       ],
     ),
    );
  }
}
