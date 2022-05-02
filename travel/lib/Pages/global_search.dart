import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:travel/components/app_drawer.dart';
import 'package:travel/components/filter_drawer.dart';
import 'package:travel/components/search_bar.dart';
import 'package:travel/components/search_card.dart';
import 'package:travel/components/top_bar.dart';
import 'package:travel/models/interessi.dart';
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

  //Filtri attualmente applicati
  String? _parolaRicerca;
  late int _minRating;
  late int _maxRating;
  late int _minPrice;
  late int _maxPrice;
  String? _country;
  bool? _available;
  bool? _recommended;
  late List<Interessi> _interessi;

  @override
  void initState() {
    super.initState();
    //Valori di default per i filtri attualmente applicati
    _minRating = 1;
    _maxRating = 5;
    _minPrice = 0;
    _maxPrice = 1000;
    _interessi = [];
    _risultatiRicerca = MetaTuristica.listaMete;
    _scaffoldkey = GlobalKey();

    //Apre il drawer con i filtri automaticamente se si preme il pulsante nella home page
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

  //Imposto i valori dei filtri dal drawer poi filtro la lista con la funzione _filtramete

  void _setAdditionalFilters({
    int minRating = 1,
    int maxRating = 5,
    int minPrice = 0,
    int maxPrice = 2000,
    String? country,
    bool? available,
    bool? recommended,
    List<Interessi> interessi = const []
  }){
    _minRating = minRating;
    _maxRating = maxRating;
    _country = country;
    _available = available;
    _recommended = recommended;
    _minPrice = minPrice;
    _maxPrice = maxPrice;
    _interessi = interessi;
    
    _filtraMete(_parolaRicerca ?? '');
  }

  bool _additionalFiltersFor(MetaTuristica meta){
    return meta.rating >= _minRating && meta.rating <= _maxRating
        && meta.minPrice >= _minPrice && meta.minPrice <= _maxPrice
        && (_country == null || meta.country == _country )
        && (_available == null || _available == false || meta.available == _available)
        && (_recommended == null || _recommended == false || meta.recommended == _recommended)
        && (_interessi.isEmpty || (meta.interessi?.any((interesse) => _interessi.contains(interesse)) ?? false));
  }

  void _filtraMete(String parolaRicerca){
    //setta la variabile di stato basandosi sul parametro scritto nella barra di ricerca
    _parolaRicerca = parolaRicerca;
    if(parolaRicerca == ''){
      setState(() {
        //se non filtro per parola, applico soltanto i filtri del drawer
        //genero una lista dove gli elementi sono elmenti della listaMete che rispettano i filtri inseriti
        _risultatiRicerca = MetaTuristica.listaMete.where((meta) {
          return _additionalFiltersFor(meta);
        }).toList();
      });
    } else {
      //applico sia i filtri che la ricerca per parola
      setState(() {
        _risultatiRicerca = MetaTuristica.listaMete.where((meta) {
            return (meta.city.toLowerCase().contains(parolaRicerca.toLowerCase()) && _additionalFiltersFor(meta));
      }).toList();
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
        setFilters: _setAdditionalFilters,
        selectedCountry: _country,
        available: _available,
        selectedPrice: RangeValues(_minPrice.toDouble(), _maxPrice.toDouble()),
        recommended: _recommended,
        interessi: _interessi,
      ),
      appBar: const TopBar(),
      drawer: const AppDrawer(),
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
