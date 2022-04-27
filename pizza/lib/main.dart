import 'package:flutter/material.dart';
import 'package:pizza/models/pizza.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _preferiti = [];

  void initFavorites() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      //sp = await SharedPreferences.getInstance();
      _preferiti = sp.getStringList('preferiti') ?? [];
    });
  }

  void addFavorite(String id) async {
    setState(() {
      _preferiti.add(id); //aggiungo l'id del preferito alla lista
    });
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setStringList('preferiti', _preferiti); //lo salvo permanentemente
  }
  
  void removeFavorite(String id) async {
    setState(() {
      _preferiti.remove(id); //aggiungo l'id del preferito alla lista
    });
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setStringList('preferiti', _preferiti); //lo salvo permanentemente
  }

  @override
  void initState(){
    initFavorites();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: const Text("Pizza"),
     ),
     body: ListView.builder(
       itemCount: Pizza.listaPizze.length,
       itemBuilder: (context, index){
         var nPizza = Pizza.listaPizze[index]; //variabile che contiene quel parametro lungo da scrivere
         return ListTile(
           title: Text(nPizza.nome),
           trailing: IconButton(
             icon: _preferiti.contains(nPizza.id) ? const Icon(Icons.favorite, color: Colors.red,) : const Icon(Icons.favorite_border),
             onPressed: (){
               _preferiti.contains(nPizza.id) ? removeFavorite(nPizza.id) : addFavorite(nPizza.id);
               },
           ),
         );
       }
     ),
   );
  }
}
