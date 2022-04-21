import 'package:flutter/material.dart';

enum Interessi {
  mare,
  montagna,
  lago,
  bosco,
  spa,
}

extension InteressiExtension on Interessi{

  IconData get icon{
    switch(this){
      case Interessi.mare:
        return Icons.sailing;
      case Interessi.montagna:
        return Icons.hiking;
      case Interessi.lago:
        return Icons.local_florist;
      case Interessi.bosco:
        return Icons.park;
      case Interessi.spa:
        return Icons.spa;
    }
  }

  Color get color{
    switch(this){
      case Interessi.mare:
        return Colors.amber;
      case Interessi.montagna:
        return Colors.lightBlue;
      case Interessi.lago:
        return Colors.greenAccent;
      case Interessi.bosco:
        return Colors.green.shade600;
      case Interessi.spa:
        return Colors.pinkAccent;
    }
  }
}