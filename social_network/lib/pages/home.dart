import 'package:flutter/material.dart';
import 'package:social_network/api/api_post.dart';
import 'package:social_network/components/post_widget.dart';
import 'package:social_network/components/top_bar.dart';
import 'package:social_network/models/post_response.dart';

import '../components/bottom_bar.dart';
import '../models/post.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late List<Post> _listaPost;
  late int _skipPost;
  late int _page;
  late bool _hasMorePost;
  late Future<List<Post>> _future;

  Future<List<Post>> _fetchPosts() async {
    final PostResponse result = await ApiPost.getPostList(page: _page);
    setState(() {
      _skipPost = _skipPost + result.limit;
      _hasMorePost = (result.total - _skipPost) > 0;
      _page++;
      _listaPost = _listaPost + result.data;
    });
    return _listaPost;
  }

  @override
  void initState() {
    super.initState();
    _listaPost = [];
    _skipPost = 0;
    _page = 0;
    _hasMorePost = false;
    _future = _fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(),
      bottomNavigationBar: const BottomBar(),
      body: RefreshIndicator(
        onRefresh: () {
          setState(() {
            _listaPost = [];
            _hasMorePost = false;
            _skipPost = 0;
            _page = 0;
            _future = _fetchPosts();
          });
          return Future.value();
        },
        child: FutureBuilder(
          future: _future,
          builder: (context, snapshot){
            //snapshot è il contenuto del future nella attuale iterazione, il future è il risultato dell'operazione fetch
            //Controlliamo se al suo interno sono presenti dati di tipo List<Post>
            if (snapshot.hasData && snapshot.data is List<Post>) {
              //Questa lista contiene i post che stiamo visualizzando
              final _listPostVisualizzati = (snapshot.data as List<Post>);

              //Costruisco la ListView che mi mostra tutti i post
              return ListView.builder(
                // itemCount = lunghezza della lista con i dati dei post (+ 1 se ci sono altri post)
                itemCount: _listPostVisualizzati.length + (_hasMorePost ? 1 : 0),
                itemBuilder: (context, index) {
                  //Se siamo arrivati a stampare l'ultimo post della lista
                  if(index == _listPostVisualizzati.length){
                    // chiamiamo di nuovo la funzione fetchPost per aggiungere un'altra pagina di post alla list
                    _future = _fetchPosts();
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
                  child: Text("Errore nel caricamento: ${snapshot.error}", style: TextStyle(fontSize: 30),)
              );
            }

            return const Center(
                child: CircularProgressIndicator()
            );
          },
        ),
      ),
    );
  }
}
