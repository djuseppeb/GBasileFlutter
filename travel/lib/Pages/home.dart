import 'package:flutter/material.dart';
import 'package:travel/components/app_drawer.dart';
import 'package:travel/components/popular_list.dart';
import 'package:travel/components/search_bar.dart';
import 'package:travel/components/recommended_list.dart';
import 'package:travel/components/top_bar.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              //CategoryList(),
              SearchBar(isHomePage: true),
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
