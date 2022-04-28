import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:travel/components/filter_drawer.dart';
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
  late bool endDrawerOpen;
  late final GlobalKey<ScaffoldState> _scaffoldkey;

  String? _parolaRicerca;
  late int _minRating;
  late int _maxRating;
  late int _minPrice;
  late int _maxPrice;
  String? _country;
  bool? _available;
  bool? _recommended;

  @override
  void initState() {
    super.initState();

    _minRating = 1;
    _maxRating = 5;

    _minPrice = 0;
    _maxPrice = 1000;

    _risultatiRicerca = MetaTuristica.listaMete;
    _scaffoldkey = GlobalKey();

    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      final modalArgs = ModalRoute.of(context)?.settings.arguments ?? {};
      if(modalArgs is List
          && modalArgs.isNotEmpty
          && modalArgs[0] is Map<String, dynamic>
          && modalArgs[0]['openDrawer'] == true){
        _scaffoldkey.currentState?.openEndDrawer();
      }
    });
  }

  void _additionalFilters({
    int minRating = 1,
    int maxRating = 5,
    int minPrice = 0,
    int maxPrice = 2000,
    String? country,
    bool? available,
    bool? recommended
}){
    setState(() {
      _minRating = minRating;
      _maxRating = maxRating;
      _country = country;
      _available = available;
      _recommended = recommended;
      _minPrice = minPrice;
      _maxPrice = maxPrice;

      _filtraMete(_parolaRicerca ?? '');

      _risultatiRicerca = _risultatiRicerca.where((risultato){
        return
          risultato.rating >= minRating && risultato.rating <= maxRating
              && (country == null || risultato.country == country)
              && (available == null || risultato.available == available)
              && risultato.minPrice >= minPrice && risultato.minPrice <= maxPrice
              && (recommended == null || risultato.recommended == recommended);
      }).toList();
    });
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
      key: _scaffoldkey,
      endDrawer: FilterDrawer(
          selectedRating: RangeValues(
              _minRating.toDouble(), _maxRating.toDouble()
          ),
        setFilters: _additionalFilters,
        selectedCountry: _country,
        available: _available,
        selectedPrice: RangeValues(_minPrice.toDouble(), _maxPrice.toDouble()),
        recommended: _recommended,
      ),
      appBar: const TopBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
        child: Column(
          children: [
            SearchBar(
              isHomePage: false,
              callback: _filtraMete,
            ),
            if (_risultatiRicerca.isNotEmpty) Text ("Found ${_risultatiRicerca.length} results"),
            _risultatiRicerca.isEmpty ? const Text("No results")
            : Expanded(
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
