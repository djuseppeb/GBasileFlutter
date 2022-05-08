import 'package:flutter/material.dart';
import 'package:login/pages/login.dart';
import 'package:login/pages/register.dart';

generateRoutes(){
  return{
    '/login' : (context) => const Center(child: Login(),),
    '/register' : (context) => const Center(child: Register(),),
  };
}