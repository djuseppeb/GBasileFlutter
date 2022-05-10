import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_network/pages/edit_profile.dart';

class SettingsSidebar extends StatefulWidget {
  const SettingsSidebar({Key? key}) : super(key: key);

  @override
  State<SettingsSidebar> createState() => _SettingsSidebarState();
}

class _SettingsSidebarState extends State<SettingsSidebar> {

  late String? userId;

  initShared() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    userId = sp.getString('user');
  }

  @override
  void initState() {
    initShared();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 2,
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text("Modifica informazioni"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile(userId: userId!,)));
              },
            ),
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
            ),

          ],
        ),
      ),
    );
  }
}
