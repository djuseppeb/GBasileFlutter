import 'package:flutter/material.dart';

enum EditPost{
  modifica,
  elimina
}

class DropdownPost extends StatelessWidget {
  final Function callDelete;
  final Function callEdit;
  const DropdownPost({Key? key, required this.callDelete, required this.callEdit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<EditPost>(
      onSelected: (EditPost result){
        switch(result){

          case EditPost.modifica:
            callEdit();
            break;
          case EditPost.elimina:
            callDelete();
            break;
        }
      },
      itemBuilder: (context) =>
        <PopupMenuEntry<EditPost>>[
          const PopupMenuItem<EditPost>(
            value: EditPost.modifica,
            child: Text("Modifica"),
          ),
          const PopupMenuItem<EditPost>(
              value: EditPost.elimina,
              child: Text("Elimina"),
          )
        ],
    );
  }
}
