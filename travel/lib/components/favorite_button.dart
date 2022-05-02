import 'package:flutter/material.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:travel/models/meta_turistica.dart';

class FavoriteButton extends StatefulWidget {
  final MetaTuristica meta;
  final Function? callback;
  const FavoriteButton(this.meta, {Key? key, this.callback}) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  List<String> _preferiti = [];
  bool isFave = false;

  initSP() async{
    final sp = await StreamingSharedPreferences.instance;
    final favorites = sp.getStringList("preferiti", defaultValue: []).getValue();
    setState(() {
      isFave = favorites.contains(widget.meta.city);
    });
  }

  changeSP() async{
    final sp = await StreamingSharedPreferences.instance;
    var favorites = sp.getStringList("preferiti", defaultValue: []).getValue();
    if(isFave){
      favorites.remove(widget.meta.city);
    } else {
      favorites.add(widget.meta.city);
    }
    sp.setStringList("preferiti", favorites);

    setState(() {
      isFave = !isFave;
    });
  }

  @override
  void initState(){
    super.initState();
    initSP();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12)),
      child: IconButton(
          onPressed: changeSP,
          icon: isFave ? const Icon(Icons.bookmark, color: Colors.amber) : const Icon(Icons.bookmark_outline, color: Colors.black),
      ),
    );
  }
}
