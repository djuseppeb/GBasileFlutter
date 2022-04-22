import 'package:flutter/material.dart';
import 'package:travel/components/app_drawer.dart';
import 'package:travel/components/category_list.dart';
import 'package:travel/components/popular_list.dart';
import 'package:travel/components/search_bar.dart';
import 'package:travel/components/recommended_list.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.grey),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Row(mainAxisSize: MainAxisSize.min, children: const [
          Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 18,
          ),
          Text(
            "Italia",
            style: TextStyle(color: Colors.blue, fontSize: 16),
          )
        ]),
        actions: const [
          CircleAvatar(
            backgroundColor: Colors.amber,
            child: Icon(
              Icons.face,
              color: Colors.white,
            ),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              CategoryList(),
              SearchBar(),
              PopularList(),
              SizedBox(height: 24),
              RecommendedList(),
            ],
          ),
        ),
      ),
    );
  }
}
