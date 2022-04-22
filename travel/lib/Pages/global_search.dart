import 'package:flutter/material.dart';
import 'package:travel/components/search_bar.dart';
import 'package:travel/components/search_card.dart';
import 'package:travel/components/top_bar.dart';
import 'package:travel/models/meta_turistica.dart';

class GlobalSearch extends StatefulWidget {
  const GlobalSearch({Key? key}) : super(key: key);

  @override
  _GlobalSearchState createState() => _GlobalSearchState();
}

class _GlobalSearchState extends State<GlobalSearch> {
  late List<MetaTuristica> _risultatiRicerca;

  @override
  void initState() {
    super.initState();
    _risultatiRicerca = MetaTuristica.listaMete;
  }

  _filtraMete(String parolaRicerca) {
    if (parolaRicerca.isEmpty) {
      setState(() {
        _risultatiRicerca = MetaTuristica.listaMete;
      });
    } else {
      setState(() {
        _risultatiRicerca = MetaTuristica.listaMete
            .where((meta) =>
                meta.city.toLowerCase().contains(parolaRicerca.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
        child: Column(
          children: [
            SearchBar(
              isHomePage: false,
              callback: _filtraMete,
            ),
            Expanded(
                child: ListView.builder(
              itemCount: _risultatiRicerca.length,
              itemBuilder: (context, index) {
                return SearchCard(_risultatiRicerca[index]);
              },
            ))
          ],
        ),
      ),
    );
  }
}
