import 'package:flutter/material.dart';
import 'package:social_network/api/api_user.dart';
import 'package:social_network/components/bottom_bar.dart';

import '../components/intestazione.dart';
import '../models/user.dart';

class Profile extends StatefulWidget {
  final String userId;
  const Profile(this.userId, {Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late User userData;
  late Future<User> _future;

  Future<User> _fetchUserData(String id) async{
    return userData = await ApiUser.getUserById(id);
  }

  @override
  void initState() {
    _future = _fetchUserData(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: const BottomBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          //Intestazione Profilo
          child: FutureBuilder(
            future: _future,
            builder: (context, snapshot){
              if (snapshot.hasData && snapshot.data is User){
                return Intestazione(userData);
              }
              if (snapshot.hasError){
                return Center(
                    child: Text("Errore nel caricamento: ${snapshot.error}", style: TextStyle(fontSize: 24),)
                );
              }
              return const Center(
                  child: CircularProgressIndicator()
              );
            },
          ),
        ),
      )
    );
  }
}
