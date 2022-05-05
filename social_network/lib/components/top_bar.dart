import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopBar extends StatelessWidget with PreferredSizeWidget{
  final String title;
  const TopBar({required this.title, Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(48);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: GoogleFonts.ubuntu(fontSize: 24, color: Colors.black)),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black54),
      /*actions: [
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
      ],*/
    );
  }
}
