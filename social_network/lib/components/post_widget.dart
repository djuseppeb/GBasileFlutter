import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_network/api/api_post.dart';
import 'package:social_network/components/dropdown_post.dart';
import 'package:social_network/components/post_modal.dart';
import 'package:social_network/pages/post_comments.dart';
import '../models/post.dart';
import '../pages/profile.dart';

class PostWidget extends StatefulWidget {
  final Post postData;
  final Function? callback;
  const PostWidget(this.postData, {Key? key, this.callback}) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  String? userId;

  late SharedPreferences _sp;

  //variabili per i like
  bool _liked = false;
  late int _numLike;
  late List<String> _listaLike;


  void editPost() async {
    bool popResult = await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return PostModal(post: widget.postData,);
        }
    );
    if(popResult == true){
      setState(() {
        if (widget.callback != null) {
          widget.callback!();
        }
      });
    }
  }

  void deletePost() async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Vuoi davvero eliminare il post?"),
          content: const Text("Questa azione non è reversibile, il post verrà perduto per sempre!"),
          actions: [
            TextButton(
                onPressed: () async{
                  if(widget.postData.id != null) {
                    await ApiPost.deletePost(widget.postData.id!);
                    setState(() {
                      if (widget.callback != null) {
                        widget.callback!();
                      }
                    });
                  }
                  Navigator.of(context).pop();
                },
                child: const Text("Sì!")
            ),
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("No")
            ),

          ],
        ),
      barrierDismissible: false,
        );
  }

  initPref () async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      userId = sp.getString('user') ?? '';
      final listaLike = sp.getStringList('like_$userId') ?? [];
      _liked = listaLike.contains(widget.postData.id);
      _listaLike = listaLike;
      _sp = sp;
    });
  }

  toggleLike() async{
    _liked ? _listaLike.remove(widget.postData.id) : _listaLike.add(widget.postData.id!);

    await _sp.setStringList('like_$userId', _listaLike);

    _liked ? _numLike-- : _numLike++;
    
    await ApiPost.updatePost(Post(id: widget.postData.id, likes: _numLike));

    setState(() {
      _liked = !_liked;
    });
  }

  @override
  void initState() {
    initPref();
    _numLike = widget.postData.likes ?? 0;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical:24, horizontal: 16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //User data
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(widget.postData.owner!.id!))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(widget.postData.owner?.picture ?? "https://via.placeholder.com/150"),
                        ),
                        const SizedBox(width: 16),
                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text("${widget.postData.owner?.firstName} ${widget.postData.owner?.lastName}",
                              style: GoogleFonts.ubuntu(
                                  fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
                          if (widget.postData.publishDate != null)
                            Text(DateFormat.yMMMMd('it_IT').add_Hm().format(DateTime.parse(widget.postData.publishDate!)),
                              style: GoogleFonts.ubuntu(fontSize: 16, color: Colors.black54)),
                        ]),
                      ],
                    ),
                    if (widget.postData.owner?.id == userId)
                      DropdownPost(callEdit: editPost, callDelete: deletePost,),
                  ],
                ),
              ),
              //Post data
              //Didascalia
              if(widget.postData.text != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text((widget.postData.text!), style: GoogleFonts.ubuntu(fontSize: 16, color: Colors.black)),
                ),

              //Immagine
              if(widget.postData.image != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Image.network(widget.postData.image!),
                ),

              //Lista dei tag
              if (widget.postData.tags != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Wrap(
                    spacing: 6,
                    children:widget.postData.tags!.map((tag) => Chip(label: Text(tag))).toList(),
                  ),
                ),

              const Divider(thickness: 2,),
              //Likes and comments
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Likes
                  Expanded(
                    child: TextButton(
                      onPressed: (){
                        setState(() {
                          toggleLike();
                        });

                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.thumb_up_rounded, color: _liked ? Colors.pink : Colors.black87),
                          Text("$_numLike", style: GoogleFonts.ubuntu(fontSize: 16, color: Colors.black))
                        ],
                      ),
                    ),
                  ),
                  //Comments
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PostComments(postData: widget.postData,)));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.comment_rounded, color: Colors.black87,),
                          Text("Commenti", style: GoogleFonts.ubuntu(fontSize: 16, color: Colors.black))
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}