import 'package:flutter/material.dart';
import 'package:prova_json/api/api_user.dart';
import 'package:prova_json/models/user_response.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Utenti"),
        ),
      body: FutureBuilder(
        future: ApiUser.getUserFromInternet(),
        builder: (context, snapshot){
          if(snapshot.hasData && snapshot.data is UserResponse){
            //risposta ottenuta, ho ciò che mi serve ed è del tipo che mi serve
            final listUser = (snapshot.data as UserResponse).users;

            return ListView.builder(
                itemCount: listUser.length,
                itemBuilder: (context, index){
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
    );
  }
}
