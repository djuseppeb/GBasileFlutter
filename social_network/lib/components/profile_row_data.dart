import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileRowData extends StatelessWidget {
  final String data;
  final IconData icon;
  const ProfileRowData({Key? key, required this.data, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 8,),
          Text(data, style: GoogleFonts.ubuntu(fontSize: 16, color: Colors.black87))
        ],
      ),
    );
  }
}
