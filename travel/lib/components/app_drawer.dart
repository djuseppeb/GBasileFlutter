import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            DrawerHeader(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircleAvatar(
                    radius: 46,
                    backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzHQv_th9wq3ivQ1CVk7UZRxhbPq64oQrg5Q&usqp=CAU"),
                  ),
                  SizedBox(height: 12,),
                  Text("Nome Cognome"),
                ],
              ),
            ),
            //Profilo, Home page, Preferiti, Ricerca
            ListTile(
              onTap: () => Navigator.of(context).popAndPushNamed("/home"),
              leading: const Icon(Icons.home),
              title: const Text("Home"),
            ),
            ListTile(
              onTap: () => Navigator.of(context).popAndPushNamed("/profile"),
              leading: const Icon(Icons.person),
              title: const Text("Account"),
            ),
            ListTile(
              onTap: () => Navigator.of(context).popAndPushNamed("/favorite"),
              leading: const Icon(Icons.star),
              title: const Text("Favorite"),
            ),
            ListTile(
              onTap: () => Navigator.of(context).popAndPushNamed("/search"),
              leading: const Icon(Icons.travel_explore),
              title: const Text("Global Search"),
            ),
            ListTile(
              onTap: () => Navigator.of(context).popAndPushNamed("/"),
              leading: Icon(Icons.logout),
              title: Text("Log Out"),
            )
          ],
        ),
      ),
    );
  }
}
