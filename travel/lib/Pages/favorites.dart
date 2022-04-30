import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel/components/app_drawer.dart';
import 'package:travel/components/carousel_title.dart';
import 'package:travel/components/favorite_button.dart';
import 'package:travel/components/search_card.dart';
import 'package:travel/components/top_bar.dart';

import 'package:travel/models/meta_turistica.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key,}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  List<String> _preferiti = [];
  final List<MetaTuristica> _listaPreferiti = [];

  void initFavoriteList() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      _preferiti = sp.getStringList('preferiti') ?? [];

      //Genero lista mete preferite
      for (var meta in MetaTuristica.listaMete) {
        if (_preferiti.contains(meta.city)){
          _listaPreferiti.add(meta);
        }
      }

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
      appBar: const TopBar(),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          const CarouselTitle("Preferiti"),
          Expanded(
            child: ListView.builder(
                itemCount: _listaPreferiti.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      SearchCard(_listaPreferiti[index]),
                      FavoriteButton(_listaPreferiti[index])
                    ],
                  );
                  },
            ),
          ),
        ],
      ),
    );
  }
}
