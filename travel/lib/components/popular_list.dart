import 'package:flutter/material.dart';
import 'package:travel/components/carousel_title.dart';
import 'package:travel/models/meta_turistica.dart';
import 'package:travel/components/card_place.dart';

class PopularList extends StatelessWidget {
  const PopularList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CarouselTitle("Popular places"),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: MetaTuristica.listaMete.length,
            itemBuilder: (context, index) {
              if (MetaTuristica.listaMete[index].raccomanded) {
                return CardPlace(
                  MetaTuristica.listaMete[index],
                );
              }
              return const SizedBox(width: 0);
            },
          ),
        ),
      ],
    );
  }
}
