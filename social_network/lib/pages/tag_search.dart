import 'package:flutter/material.dart';
import 'package:social_network/components/bottom_bar.dart';
import 'package:social_network/components/top_bar.dart';

import '../api/api_post.dart';
import '../components/post_widget.dart';
import '../models/post.dart';
import '../models/post_response.dart';

class TagSearch extends StatefulWidget {
  const TagSearch({Key? key}) : super(key: key);

  @override
  State<TagSearch> createState() => _TagSearchState();
}

class _TagSearchState extends State<TagSearch> {
  late TextEditingController _searchController;
  late String _tagRicerca;

  late List<Post> _listaPost;
  late int _skipPost;
  late int _page;
  late bool _hasMorePost;
  late Future<List<Post>> _future;

  Key _key = UniqueKey();

  void refreshKey(){
    setState(() {
      _key = UniqueKey();
    });
  }

  Future<List<Post>> _fetchPosts() async {
    final PostResponse result = await ApiPost.getPostByTag(_tagRicerca, page: _page);
    setState(() {
      _skipPost = _skipPost + result.limit;
      _hasMorePost = (result.total - _skipPost) > 0;
      _page++;
      _listaPost = _listaPost + result.data;
    });
    return _listaPost;
  }
  void initVars() {
    _listaPost = [];
    _skipPost = 0;
    _page = 0;
    _hasMorePost = false;
    _future = _fetchPosts();
  }

  @override
  void initState() {
    super.initState();
    _tagRicerca = '';
    initVars();
    _searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(title: 'Ricerca'),
      bottomNavigationBar: const BottomBar(currentPage: 'search'),
      body: Column(
        children: [
          //Barra ricerca tag
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: "Cerca un tag",
                icon: Icon(Icons.search),
              ),
              onChanged: (value) {
                _tagRicerca = _searchController.text;
                refreshKey();
                initVars();
              },
            ),
          ),

          Expanded(
            child: FutureBuilder(
              key: _key,
              future: _future,
              builder: (context, snapshot){
                //snapshot è il contenuto del future nella attuale iterazione, il future è il risultato dell'operazione fetch
                //Controlliamo se al suo interno sono presenti dati di tipo List<Post>
                if (snapshot.hasData && snapshot.data is List<Post>) {
                  //Questa lista contiene i post che stiamo visualizzando
                  final _listPostVisualizzati = (snapshot.data as List<Post>);

                  //Costruisco la ListView che mi mostra tutti i post
                  return ListView.builder(
                    shrinkWrap: true,
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
                      return PostWidget(_listPostVisualizzati[index], callback: initVars,);
                    },
                  );
                }
                if (snapshot.hasError){
                  return const Center(
                      child: Text("Nessun risultato", style: TextStyle(fontSize: 24),)
                  );
                }

                return const Center(
                    child: CircularProgressIndicator()
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
