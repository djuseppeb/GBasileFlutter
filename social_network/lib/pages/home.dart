import 'package:flutter/material.dart';
import 'package:social_network/api/api_post.dart';
import 'package:social_network/components/post_widget.dart';
import 'package:social_network/components/top_bar.dart';
import 'package:social_network/models/post_response.dart';
import 'package:social_network/components/bottom_bar.dart';
import 'package:social_network/models/post.dart';
import 'package:social_network/models/user.dart';

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

  //attributi per condividere un Post
  late String _postMessage;
  String _postImage = "https://img.dummyapi.io/photo-1564694202779-bc908c327862.jpg";
  late String _postTags;
  late List<String> _postTagsList;

  late TextEditingController _messageController;
  late TextEditingController _tagsController;

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
    _messageController = TextEditingController();
    _tagsController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool popResult = await showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return Padding(
                  padding: EdgeInsets.only(
                    top: 8,
                    left: 8,
                    right: 8,
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _messageController,
                      maxLines: 5,
                      onChanged: (value){
                        _postMessage = _messageController.text;
                      },
                      decoration: const InputDecoration(
                        hintText: "Scrivi una didascalia...",
                        icon: Icon(Icons.create),
                      ),
                    ),
                    TextField(
                      controller: _tagsController, //sono un imbecille
                      maxLines: 3,
                      onChanged: (value){
                        _postTags = _tagsController.text;
                        print(_postTags);
                        _postTagsList = _postTags.split(", ");
                        print(_postTagsList);
                      },
                      decoration: const InputDecoration(
                        hintText: "Aggiungi dei tag separati da una virgola con spazio.",
                        icon: Icon(Icons.sell),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          child: Text("Annulla"),
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                        ),
                        ElevatedButton(
                          child: Text("Pubblica"),
                          onPressed: () async{
                            User _newUser = const User(id: '60d0fe4f5311236168a109ca', firstName: 'Sara', lastName: 'Andersen');
                            Post newPost = Post(text: _postMessage, image: _postImage, tags: _postTagsList, owner: _newUser);

                            if(newPost.text == null){
                              Navigator.of(context).pop();
                            }
                            await ApiPost.newPost(newPost);
                            _postMessage = '';
                            _messageController.clear();
                            _postTags = '';
                            _postTagsList = [];
                            _tagsController.clear();
                            Navigator.of(context).pop(true);
                          },
                        )
                      ],
                    )
                  ],
                ),
              );
            }
          );
        },
        child: const Icon(Icons.create),
      ),

      appBar: const TopBar(title: "DummySocial"),
      bottomNavigationBar: const BottomBar(currentPage: "home",),
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
                  child: Text("Errore nel caricamento: ${snapshot.error}", style: const TextStyle(fontSize: 24),)
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
