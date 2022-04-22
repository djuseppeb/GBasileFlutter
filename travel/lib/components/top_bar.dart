import 'package:flutter/material.dart';

class TopBar extends StatelessWidget with PreferredSizeWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(54);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.grey),
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Row(mainAxisSize: MainAxisSize.min, children: const [
        Icon(
          Icons.location_on,
          color: Colors.blue,
          size: 18,
        ),
        Text(
          "Italia",
          style: TextStyle(color: Colors.blue, fontSize: 16),
        )
      ]),
      actions: const [
        CircleAvatar(
          backgroundColor: Colors.amber,
          child: Icon(
            Icons.face,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
