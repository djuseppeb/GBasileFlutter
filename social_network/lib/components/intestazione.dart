import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:social_network/components/profile_row_data.dart';

import '../models/user.dart';

class Intestazione extends StatelessWidget {
  final User userData;
  const Intestazione(this.userData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        //Nome e foto
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 68,
              backgroundColor: Colors.deepPurpleAccent.shade100,
              child: CircleAvatar(
                radius: 64,
                backgroundImage: NetworkImage(userData.picture ?? "https://via.placeholder.com/150"),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text("${userData.firstName} ${userData.lastName}", style: GoogleFonts.ubuntu(fontSize: 30, color: Colors.black,)),
              ),
            )
          ],
        ),

        SizedBox(height: 16,),
        Divider(thickness: 2,),
        //Informazioni
        Column(
          children: [
            if (userData.dateOfBirth != null)
              ProfileRowData(data: DateFormat.yMMMMd('it_IT').format(DateTime.parse(userData.dateOfBirth!)), icon: Icons.cake),

            if (userData.location != null)
              ProfileRowData(icon: Icons.place, data: "${userData.location?.city ?? ""} ${userData.location?.country ?? ""}"),

            if (userData.email != null)
              ProfileRowData(data: userData.email!, icon: Icons.email),

            if (userData.phone != null)
              ProfileRowData(data: userData.phone!, icon: Icons.phone)
          ],
        ),

        Divider(thickness: 2,),
      ],
    );
  }
}
