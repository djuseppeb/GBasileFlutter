import 'package:flutter/material.dart';
import 'package:travel/components/carousel_title.dart';
import 'package:travel/components/place_main_card.dart';
import 'package:travel/models/meta_turistica.dart';

class DetailsPage extends StatelessWidget {
  final MetaTuristica meta;
  const DetailsPage(this.meta, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(meta.imageUrl), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //BUTTONS
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(
                          Icons.chevron_left,
                          color: Colors.black,
                        )),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: IconButton(
                        onPressed: () => ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                content: Text("Added to favorites"))),
                        icon: const Icon(
                          Icons.bookmark,
                          color: Colors.black,
                        )),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.only(top:100),
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        clipBehavior: Clip.hardEdge,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 46),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24)),
                        child: ListView(
                          shrinkWrap: true,
                          //mainAxisSize: MainAxisSize.max,
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CarouselTitle("Great Place to visit"),
                            Text(meta.description),

                            const SizedBox(height: 14),

                            const CarouselTitle("Pictures"),
                            SizedBox(
                              height: 100,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          image: const DecorationImage(
                                            image: NetworkImage(
                                                "https://www.ansa.it/webimages/img_457x/2022/1/11/13f036403c0422c051a142c6214988da.jpg"),
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          image: const DecorationImage(
                                            image: NetworkImage(
                                                "https://www.ansa.it/webimages/img_457x/2022/1/11/13f036403c0422c051a142c6214988da.jpg"),
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          image: const DecorationImage(
                                            image: NetworkImage(
                                                "https://www.ansa.it/webimages/img_457x/2022/1/11/13f036403c0422c051a142c6214988da.jpg"),
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          image: const DecorationImage(
                                            image: NetworkImage(
                                                "https://www.ansa.it/webimages/img_457x/2022/1/11/13f036403c0422c051a142c6214988da.jpg"),
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          image: const DecorationImage(
                                            image: NetworkImage(
                                                "https://www.ansa.it/webimages/img_457x/2022/1/11/13f036403c0422c051a142c6214988da.jpg"),
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                  )
                                ],
                              ),
                            ),

                            //MAPPA
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      color: Colors.lightBlueAccent,
                                      borderRadius: BorderRadius.circular(12),
                                      image: const DecorationImage(
                                        image: NetworkImage(
                                            "https://www.ansa.it/webimages/img_457x/2022/1/11/13f036403c0422c051a142c6214988da.jpg"),
                                        fit: BoxFit.cover,
                                      ))),
                            ),

                            //PREZZO + PULSANTE
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "\$ ${meta.minPrice}",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                      "Minimum Price",
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 14),
                                    )
                                  ],
                                ),
                                ElevatedButton(
                                  onPressed: () => ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                          content: Text("Book failed, this app is not real lmao"))),
                                  child: const Text(
                                    "Book now",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.symmetric(
                                              horizontal: 80)),
                                      backgroundColor:
                                          MaterialStateProperty.all(Colors.blue),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: PlaceMainCard(
                          city: meta.city,
                          country: meta.country,
                          rating: meta.rating),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
