import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset('assets/logo.png', width: 120,),
          Text("DummySocial", style: GoogleFonts.ubuntu(fontSize: 30)),
        ],
      ),
    );
  }
}
