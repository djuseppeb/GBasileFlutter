import 'package:flutter/material.dart';
import 'package:social_network/api/api_user.dart';
import 'package:social_network/components/bottom_bar.dart';
import 'package:social_network/components/settings_sidebar.dart';
import 'package:social_network/components/top_bar.dart';

import '../api/api_post.dart';
import '../components/intestazione.dart';
import '../components/post_widget.dart';
import '../models/post.dart';
import '../models/post_response.dart';
import '../models/user.dart';

class Profile extends StatefulWidget {
  final String userId;
  const Profile(this.userId, {Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  //Dati intestazione
  late User userData;
  late Future<User> _futureUser;

  //Dati timeline dei post
  late List<Post> _listaPost;
  late int _skipPost;
  late int _page;
  late bool _hasMorePost;
  late Future<List<Post>> _futurePost;



  //Funzioni di fetch
  Future<User> _fetchUserData(String id) async{
    return userData = await ApiUser.getUserById(id);
  }

  Future<List<Post>> _fetchPostData() async{
    final PostResponse result = await ApiPost.getPostByUser(widget.userId, page: _page);
    setState(() {
      _skipPost = _skipPost + result.limit;
      _hasMorePost = (result.total - _skipPost) > 0;
      _page++;
      _listaPost = _listaPost + result.data;
    });
    return _listaPost;
  }


  //InitState
  @override
  void initState() {
    _futureUser = _fetchUserData(widget.userId);

    _listaPost = [];
    _skipPost = 0;
    _page = 0;
    _hasMorePost = false;
    _futurePost = _fetchPostData();

    super.initState();
  }


  //Build
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const TopBar(title: 'Profilo',),
      endDrawer: const SettingsSidebar(),
      bottomNavigationBar: const BottomBar(currentPage: "profile",),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FutureBuilder(
                future: _futureUser,
                builder: (context, snapshot){
                  if (snapshot.hasData && snapshot.data is User){
                    return Intestazione(userData);
                  }
                  if (snapshot.hasError){
                    return Center(
                        child: Text("Errore nel caricamento: ${snapshot.error}", style: const TextStyle(fontSize: 24),)
                    );
                  }
                  return const Center(
                      child: CircularProgressIndicator()
                  );
                },
              ),
            ),

            //Post dell'utente
            FutureBuilder(
              future: _futurePost,
              builder: (context, snapshot){
                if(snapshot.hasData && snapshot.data is List<Post>){
                  final _listPostVisualizzati = (snapshot.data as List<Post>);

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    // itemCount = lunghezza della lista con i dati dei post (+ 1 se ci sono altri post)
                    itemCount: _listPostVisualizzati.length + (_hasMorePost ? 1 : 0),
                    itemBuilder: (context, index) {
                      //Se siamo arrivati a stampare l'ultimo post della lista
                      if(index == _listPostVisualizzati.length){
                        // chiamiamo di nuovo la funzione fetchPost per aggiungere un'altra pagina di post alla list
                        _futurePost = _fetchPostData();
                        // nel frattempo che carico, mostro un simbolo di attesa
                        return const Center(child: CircularProgressIndicator(),);
                      }
                      //Stampo la card con i dati del post
                      return PostWidget(_listPostVisualizzati[index]);
                    },
                  );
                }

                if (snapshot.hasError){
                  return Center(
                      child: Text("Errore nel caricamento: ${snapshot.error}", style: const TextStyle(fontSize: 24),)
                  );
                }

                return const Center(
                    child: CircularProgressIndicator()
                );
              }
            )
          ],
        ),
      )
    );
  }
}
