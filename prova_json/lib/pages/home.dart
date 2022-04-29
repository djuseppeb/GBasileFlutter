import 'package:flutter/cupertino.dart';
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
                    return Container(
                      //width: MediaQuery.of(context).size.width,
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(listUser[index].image),
                              backgroundColor: listUser[index].gender.toLowerCase() == 'male' ? Colors.lightBlue.shade100 : Colors.pink.shade100,
                              radius: 48,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Text("@${listUser[index].username}",style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                ),

                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Text("${listUser[index].firstName} ${listUser[index].lastName}", style: const TextStyle(fontSize: 16),),
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.cake, color: Colors.pinkAccent, size: 14,),
                                    Text(listUser[index].birthDate, style: const TextStyle(fontSize: 14, color: Colors.black54)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.phone, color: Colors.green, size: 14,),
                                    Text(listUser[index].phone, style: const TextStyle(fontSize: 14, color: Colors.black54)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.mail, color: Colors.amber, size: 14,),
                                    Text(listUser[index].email, style: const TextStyle(fontSize: 14, color: Colors.black54)),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.location_on, color: Colors.blue, size: 14,),
                                    Expanded(child: Text(listUser[index].address.toString(), style: const TextStyle(fontSize: 14, color: Colors.black54))),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
