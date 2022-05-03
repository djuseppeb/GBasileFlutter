import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCard extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String firstName;
  final String lastName;
  const LoginCard({Key? key, required this.id, required this.imageUrl, required this.firstName, required this.lastName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            SharedPreferences sp = await SharedPreferences.getInstance();
            sp.setBool('logged', true);
            sp.setString('user', id);
            Navigator.of(context).popAndPushNamed('/home');
          },
          child: Container(
            width: 142,
            height: 142,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(12)
            ),
          ),
        ),
        const SizedBox(height: 6,),
        Text("$firstName $lastName", style: GoogleFonts.ubuntu(fontSize: 16)),
      ],
    );
  }
}
