import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel/components/app_drawer.dart';
import 'package:travel/components/top_bar.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  List<String> _preferiti = [];

  void initFavoriteList() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      _preferiti = sp.getStringList('preferiti') ?? [];
    });
  }

  @override
  void initState() {
    initFavoriteList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      drawer: AppDrawer(),
      body: ListView.builder(
          itemCount: _preferiti.length,
          itemBuilder: (context, index) {
            return Text(_preferiti[index]);
          },),
    );
  }
}
