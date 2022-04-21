import 'package:flutter/material.dart';

class CarouselTitle extends StatelessWidget {
  final String titolo;
  const CarouselTitle(this.titolo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      titolo,
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}
