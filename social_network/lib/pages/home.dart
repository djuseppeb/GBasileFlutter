import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_network/components/post_widget.dart';

import '../components/bottom_bar.dart';

class Home extends StatelessWidget {
  final String _tempText = "adult Labrador retriever";
  final String _tempImage =
      "https://img.dummyapi.io/photo-1564694202779-bc908c327862.jpg";
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DummySocial",
            style: GoogleFonts.ubuntu(fontSize: 24, color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              SharedPreferences sp = await SharedPreferences.getInstance();
              sp.setBool('logged', false);
              sp.setString('user', '');
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/', (Route<dynamic> route) => false);
            },
            icon: const Icon(Icons.logout),
            color: Colors.black,
          )
        ],
      ),
      bottomNavigationBar: const BottomBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            PostWidget(postText: _tempText, imgUrl: _tempImage),
            PostWidget(postText: "Ciao"),
            PostWidget(imgUrl: _tempImage)
          ],
        ),
      ),
    );
  }
}
