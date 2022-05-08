import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsSidebar extends StatelessWidget {
  const SettingsSidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 2,
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Esci"),
              onTap: () async{
                SharedPreferences sp = await SharedPreferences.getInstance();
                sp.setBool('logged', false);
                sp.setString('user', '');
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/', (Route<dynamic> route) => false);
              },
            )
          ],
        ),
      ),
    );
  }
}
