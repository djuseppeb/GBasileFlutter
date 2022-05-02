import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  void initFavorite() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      _preferiti = sp.getStringList('preferiti') ?? [];
    });
  }

  void toggleFavorite(String id) async{
    setState(() {
      _preferiti.contains(id) ? _preferiti.remove(id) : _preferiti.add(id);
    });
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setStringList('preferiti', _preferiti);
  }

  @override
  void initState() {
    initFavorite();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12)),
      child: IconButton(
          onPressed: () async {
            toggleFavorite(widget.meta.city);
          },
          icon: _preferiti.contains(widget.meta.city) ? const Icon(Icons.bookmark, color: Colors.amber) : const Icon(Icons.bookmark_outline, color: Colors.black),
      ),
    );
  }
}
