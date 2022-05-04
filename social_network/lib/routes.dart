import 'package:flutter/material.dart';
import 'package:social_network/pages/home.dart';
import 'package:social_network/pages/loading.dart';
import 'package:social_network/pages/login.dart';
import 'package:social_network/pages/profile.dart';

generateRoutes(){
  return{
    '/' : (context) => const Center(child: Loading()),
    '/login' : (context) => const Center(child: Login()),
    '/home' : (context) => const Center(child: Home()),
  };
}