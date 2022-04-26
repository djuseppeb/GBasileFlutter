import 'package:flutter/material.dart';
import 'package:travel/Pages/account.dart';
import 'package:travel/Pages/favorites.dart';
import 'package:travel/Pages/global_search.dart';
import 'package:travel/Pages/login.dart';
import 'package:travel/Pages/home.dart';

generateRoutes(){
  return {
    '/' : (context) => const Center(child: Login()),
    '/home' : (context) => const Center(child: Home()),
    '/profile' : (context) => const Center(child: Account()),
    '/details' : (context) => const Center(child: Text('Dettagli')),
    '/favorite' : (context) => const Center(child: Favorites()),
    '/search' : (context) => const Center(child: GlobalSearch())
  };
}