import 'package:flutter/material.dart';
import 'package:travel/models/meta_turistica.dart';

class FilterDrawer extends StatefulWidget {
  final RangeValues selectedRating;
  final String? selectedCountry;
  final bool? available;
  final bool? recommended;
  final RangeValues selectedPrice;
  final Function ({int minRating, int maxRating, int minPrice, int maxPrice, String? country, bool? available, bool? recommended}) setFilters;
  const FilterDrawer({required this.selectedRating, Key? key, this.selectedCountry, this.available = false, required this.setFilters, required this.selectedPrice, this.recommended = false}) : super(key: key);

  @override
  _FilterDrawerState createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  late RangeValues _selectedRating;
  late List<String> _countryList;
  String? _selectedCountry;
  late bool? _available;
  late bool? _recommended;
  late RangeValues _selectedPrice;

  @override
  void initState(){
    super.initState();
    _selectedRating = widget.selectedRating;
    _selectedCountry = widget.selectedCountry;
    _available = widget.available;
    _recommended = widget.recommended;
    _selectedPrice = widget.selectedPrice;

    _countryList = MetaTuristica.listaMete.map((meta) => meta.country).toSet().toList();

    _countryList.sort();
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text("Filters", style: TextStyle(fontSize: 24),),
              Expanded(
                child: Form(
                    child: ListView(
                      children: [

                        Text("By rating (${_selectedRating.start.toInt().toString()} - ${_selectedRating.end.toInt().toString()})"),
                        Row(
                          children: [
                            const Text("1"),
                            RangeSlider(
                              min: 1,
                              max: 5,
                              divisions: 4,
                              values: _selectedRating,
                              onChanged: (RangeValues value) {
                                setState(() {
                                  _selectedRating = value;
                                });
                              },
                              labels: RangeLabels(
                                _selectedRating.start.toInt().toString(),
                                _selectedRating.end.toInt().toString()
                              ),
                            ),
                            const Text("5"),
                          ],
                        ),

                        Text("By price (${_selectedPrice.start.toInt().toString()}\$ - ${_selectedPrice.end.toInt().toString()}\$)"),
                        Row(
                          children: [
                            const Text("0\$"),
                            RangeSlider(
                              min: 0,
                              max: 1000,
                              divisions: 20,
                              values: _selectedPrice,
                              onChanged: (RangeValues value) {
                                setState(() {
                                  _selectedPrice = value;
                                });
                              },
                              labels: RangeLabels(
                                  _selectedPrice.start.toInt().toString(),
                                  _selectedPrice.end.toInt().toString()
                              ),
                            ),
                            const Text("1000\$"),
                          ],
                        ),

                        FormField(builder: (context) {
                          return InputDecorator(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder()
                            ),
                            child: DropdownButtonHideUnderline(
                              child: (DropdownButton<String?>(
                                isDense: true,
                                value: _selectedCountry,
                                items: const <DropdownMenuItem<String?>>[
                                  DropdownMenuItem(
                                      child: Text("Select country"), value: null,
                                  )
                                ] + _countryList.map((country) => DropdownMenuItem<String?>(child: Text(country), value: country,)).toList(),
                                onChanged: (metaSelezionata){
                                  setState(() {
                                    _selectedCountry = metaSelezionata;
                                  });
                                },
                              )),
                            ),
                          );
                        },
                        ),

                        SwitchListTile(
                            contentPadding: EdgeInsets.zero,
                            title: const Text("Show only available"),
                            value: _available ?? false,
                            onChanged: (toggle){
                              setState(() {
                                _available = toggle;
                              });
                            }
                        ),

                        SwitchListTile(
                            contentPadding: EdgeInsets.zero,
                            title: const Text("Show only recommended"),
                            value: _recommended ?? false,
                            onChanged: (toggle){
                              setState(() {
                                _recommended = toggle;
                              });
                            }
                        ),



                        Row(
                          children: [
                            TextButton(
                                onPressed: () {
                                  setState((){
                                    _available = null;
                                    _recommended = null;
                                    _selectedCountry = null;
                                    _selectedRating = const RangeValues(1, 5);
                                    _selectedPrice = const RangeValues(0, 2000);
                                  });
                                },
                                child: const Text("Reset")
                            ),

                            TextButton(
                                onPressed: () {
                                  widget.setFilters(
                                    minRating: _selectedRating.start.toInt(),
                                    maxRating: _selectedRating.end.toInt(),
                                    minPrice: _selectedPrice.start.toInt(),
                                    maxPrice: _selectedPrice.end.toInt(),
                                    country: _selectedCountry,
                                    available: _available == false ? null: _available,
                                    recommended : _recommended == false ? null: _recommended,
                                  );
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Apply")
                            )
                          ],
                        )

                      ]
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
