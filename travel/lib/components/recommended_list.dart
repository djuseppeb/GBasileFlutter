import 'package:flutter/material.dart';
import 'package:travel/components/carousel_title.dart';
import 'package:travel/models/meta_turistica.dart';

import 'card_place.dart';

class RecommendedList extends StatelessWidget {
  const RecommendedList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CarouselTitle("Recommended"),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: MetaTuristica.listaMete.length,
            itemBuilder: (context, index){
              if(MetaTuristica.listaMete[index].rating>=5){
                return CardPlace(
                    MetaTuristica.listaMete[index],
                );
              }
              return const SizedBox(width: 0);
            },
          ),
        )
      ],
    );
  }
}
