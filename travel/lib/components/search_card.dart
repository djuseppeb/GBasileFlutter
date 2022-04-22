import 'package:flutter/material.dart';
import 'package:travel/models/meta_turistica.dart';
import 'package:travel/Pages/details_page.dart';

class SearchCard extends StatelessWidget {
  final MetaTuristica meta;
  const SearchCard(this.meta, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => DetailsPage(meta))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12)),
                      image: DecorationImage(
                          image: NetworkImage(meta.imageUrl),
                          fit: BoxFit.cover))),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      meta.city,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Text("Another journey chamber way yet",
                        style: TextStyle(fontSize: 14, color: Colors.black38)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            Text(meta.rating.toString())
                          ],
                        ),
                        const SizedBox(width: 20),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.blue,
                              size: 14,
                            ),
                            Text(
                              meta.country,
                              style: const TextStyle(
                                  color: Colors.blue, fontSize: 14),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
