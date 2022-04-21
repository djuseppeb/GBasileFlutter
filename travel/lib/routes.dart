import 'package:flutter/material.dart';

import 'Pages/home.dart';

generateRoutes(){
  return {
    '/' : (context) => const Center(child: Home()),
    '/profile' : (context) => const Center(child: Text('Profilo')),
    '/details' : (context) => const Center(child: Text('Dettagli')),
    '/favorite' : (context) => const Center(child: Text('Preferiti')),
    '/mete' : (context) => const Center(child: Text('Mete'))
  };
}