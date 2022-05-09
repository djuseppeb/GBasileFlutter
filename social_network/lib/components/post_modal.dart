import 'package:flutter/material.dart';

import '../api/api_post.dart';
import '../models/post.dart';
import '../models/user.dart';

class PostModal extends StatefulWidget {
  final Post? post;
  //Se passo un post come parametro significa che sto modificando un post già esistente,
  // altrimenti sto creando un nuovo post.
  // Le funzioni vengono richiamate in base alla presenza o meno del parametro post.
  const PostModal({Key? key, this.post,}) : super(key: key);

  @override
  State<PostModal> createState() => _PostModalState();
}

class _PostModalState extends State<PostModal> {
  //attributi per condividere un Post
  late String _postMessage;
  final String _postImage = "https://img.dummyapi.io/photo-1564694202779-bc908c327862.jpg";
  late String _postTags;
  late List<String> _postTagsList;

  late TextEditingController _messageController;
  late TextEditingController _tagsController;

  void svuotaForm(){
    //Svuoto i campi così da averli puliti quando creo il prossimo post
    _postMessage = '';
    _messageController.clear();
    _postTags = '';
    _postTagsList = [];
    _tagsController.clear();
  }

  void initVars() {
    _postMessage = widget.post!.text ?? '';
    _postTags = widget.post!.tags.toString().substring(1, widget.post!.tags.toString().length-1);
    _postTagsList = _postTags.split(", ");
    _messageController = TextEditingController(text: _postMessage);
    _tagsController = TextEditingController(text: _postTags);
  }

  @override
  void initState() {
    super.initState();
    if (widget.post == null) {
      _messageController = TextEditingController();
      _tagsController = TextEditingController();
      svuotaForm();
    } else {
      initVars();
    }
  }

  @override
  Widget build(BuildContext context) {
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
          TextFormField(
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
            controller: _tagsController,
            maxLines: 3,
            onChanged: (value){
              _postTags = _tagsController.text;
              _postTagsList = _postTags.split(", ");
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
                child: const Text("Annulla"),
                onPressed: (){
                  svuotaForm();
                  Navigator.of(context).pop();
                },
              ),
              if (widget.post != null)
                TextButton(
                  child: const Text("Elimina", style: TextStyle(color: Colors.red),),
                  onPressed: () async{
                    await ApiPost.deletePost(widget.post!.id!);
                    Navigator.of(context).pop(true);
                  }
                ),
              ElevatedButton(
                child: const Text("Pubblica"),
                onPressed: () async{
                  if (widget.post == null){
                    User _newUser = const User(id: '60d0fe4f5311236168a109ca', firstName: 'Sara', lastName: 'Andersen');
                    Post newPost = Post(text: _postMessage, image: _postImage, tags: _postTagsList, owner: _newUser);

                    if(newPost.text == null){
                      Navigator.of(context).pop();
                    }

                    await ApiPost.newPost(newPost);
                    svuotaForm();
                    Navigator.of(context).pop(true);
                  } else {
                    await ApiPost.updatePost(widget.post!.id!, _postMessage, _postTagsList);
                    Navigator.of(context).pop(true);
                  }
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
