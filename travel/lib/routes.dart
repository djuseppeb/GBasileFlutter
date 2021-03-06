import 'package:flutter/material.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:travel/Pages/account.dart';
import 'package:travel/Pages/favorites.dart';
import 'package:travel/Pages/global_search.dart';
import 'package:travel/Pages/login.dart';
import 'package:travel/Pages/home.dart';
import 'package:travel/Pages/loading.dart';

generateRoutes(StreamingSharedPreferences sp){
  return {
    '/' : (context) => const Center(child: Loading()),
    '/login' : (context) => const Center(child: Login()),
    '/home' : (context) => const Center(child: Home()),
    '/profile' : (context) => const Center(child: Account()),
    '/details' : (context) => const Center(child: Text('Dettagli')),
    '/favorite' : (context) => Center(child: Favorites(sp)),
    '/search' : (context) => const Center(child: GlobalSearch())
  };
}