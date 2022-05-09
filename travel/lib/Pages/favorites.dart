import 'package:flutter/material.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:travel/components/app_drawer.dart';
import 'package:travel/components/favorite_button.dart';
import 'package:travel/components/search_card.dart';
import 'package:travel/components/top_bar.dart';

import 'package:travel/models/meta_turistica.dart';

class Favorites extends StatelessWidget {
  final StreamingSharedPreferences sp;
  const Favorites(this.sp, {Key? key,}) : super(key: key);

  List<MetaTuristica> getMetePreferite(List<String> _preferences){
    List<MetaTuristica> metePreferite = [];
    for(var meta in MetaTuristica.listaMete){
      if (_preferences.contains(meta.city)){
        metePreferite.add(meta);
      }
    }
    return metePreferite;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(),
      drawer: const AppDrawer(),
      body: PreferenceBuilder<List<String>>(
        preference: sp.getStringList("preferiti", defaultValue: []),
        builder: (context, _preferenceResult){
          List<MetaTuristica> metePreferite = getMetePreferite(_preferenceResult);
          return ListView.builder(
              itemCount: metePreferite.length,
              itemBuilder: (context, index){
                return Row(
                  children: [
                    SearchCard(metePreferite[index]),
                    FavoriteButton(metePreferite[index])
                  ],
                );
              }
          );
        }
      )
    );
  }
}

//TODO: questa pagina è un po' buggata
