import 'package:flutter/material.dart';
import 'package:prova_json/api/api_user.dart';
import 'package:prova_json/models/user_response.dart';

import 'package:prova_json/models/user.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<User> _listUserVisualizzate;
  late bool _hasMoreUsers;
  late int _skipUsers;
  late Future<List<User>> _future;


  @override
  void initState() {
    super.initState();
    _listUserVisualizzate = [];
    _hasMoreUsers = false;
    _skipUsers = 0;
    _future = _fetchUsers();
  }

  //va a prendere gli user dal json skippando un dato numero di entry
  Future<List<User>> _fetchUsers() async{  //asincrona perchè deve andare su internet a prendere i dati
    final UserResponse result = await ApiUser.getUserFromInternet(skip: _skipUsers);
    setState(() {
      _skipUsers = _skipUsers + result.limit;
      _hasMoreUsers = (result.total - _skipUsers) > 0;
      _listUserVisualizzate = _listUserVisualizzate + result.users;
    });
    return _listUserVisualizzate;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Utenti"),
        ),
      body: RefreshIndicator(
        onRefresh: () {
          setState(() {
            _listUserVisualizzate = [];
            _hasMoreUsers = false;
            _skipUsers = 0;
            _future = _fetchUsers();
          });
          return Future.value();
        },
        child: FutureBuilder(
          future: _future,
          builder: (context, snapshot){
            if(snapshot.hasData && snapshot.data is List<User>){
              //risposta ottenuta, ho ciò che mi serve ed è del tipo che mi serve
              final listUser = (snapshot.data as List<User>);

              return ListView.builder(
                  itemCount: listUser.length + (_hasMoreUsers ? 1 : 0),
                  itemBuilder: (context, index){
                    if(index == listUser.length){
                      _future = _fetchUsers();
                      return const Center(child: CircularProgressIndicator(),);
                    }
                    return ListTile(
                      title: Text("${listUser[index].firstName} ${listUser[index].lastName}"),
                      subtitle: Text(listUser[index].phone),
                    );
                  }
              );
            }
            if (snapshot.hasError){
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            return const Center(child: CircularProgressIndicator(),);
          }
        ),
      ),
    );
  }
}
