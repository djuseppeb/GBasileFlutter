import 'package:flutter/material.dart';

class MenuLaterale extends StatelessWidget {
  const MenuLaterale({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(24),
              bottomRight: Radius.circular(24))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  image: DecorationImage(
                    image: AssetImage('assets/avatar.png'),
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          Column(
            children: const [
              ListTile(
                leading: Icon(Icons.widgets_outlined),
                title: Text("Menu options"),
              ),
              ListTile(
                leading: Icon(Icons.autorenew_outlined),
                title: Text("Refunds"),
              ),
              ListTile(
                leading: Icon(Icons.credit_card_outlined),
                title: Text("Transactions"),
              ),
              ListTile(
                leading: Icon(Icons.tune_outlined),
                title: Text("Settings"),
              ),
            ],
          ),
          const ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
          )
        ],
      ),
    );
  }
}
