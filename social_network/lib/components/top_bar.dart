import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      actions: [
        IconButton(
          onPressed: () {
            if (Scaffold.of(context).hasEndDrawer){
              Scaffold.of(context).openEndDrawer();
            }
          },
          icon: const Icon(Icons.settings),
        ),
      ],
    );
  }
}
