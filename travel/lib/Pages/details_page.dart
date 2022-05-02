import 'package:flutter/material.dart';
import 'package:travel/Pages/favorites.dart';
import 'package:travel/components/favorite_button.dart';
import 'package:travel/components/carousel_title.dart';
import 'package:travel/components/place_main_card.dart';
import 'package:travel/models/meta_turistica.dart';

class DetailsPage extends StatefulWidget {
  final MetaTuristica meta;
  const DetailsPage(this.meta, {Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(widget.meta.imageUrl), fit: BoxFit.cover),
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
                  FavoriteButton(widget.meta,),
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top:100),
                      width: MediaQuery.of(context).size.width,
                      clipBehavior: Clip.hardEdge,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 46),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))),
                      child: ListView(
                        shrinkWrap: true,
                        //mainAxisSize: MainAxisSize.max,
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CarouselTitle("Great Place to visit"),
                          Text(widget.meta.description),

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
                                              "https://live.staticflickr.com/5800/30084705221_6001bbf1ba_b.jpg"),
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
                                              "https://live.staticflickr.com/8164/7516223700_d70b7952e7_b.jpg"),
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
                                              "https://live.staticflickr.com/7003/6798701043_2f5e28b0ed_b.jpg"),
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
                                              "https://live.staticflickr.com/8492/8303796946_63bc6b9007_b.jpg"),
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
                                              "https://live.staticflickr.com/149/424710073_18f6701cea_b.jpg"),
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
                                    "\$ ${widget.meta.minPrice}",
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
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: PlaceMainCard(
                          city: widget.meta.city,
                          country: widget.meta.country,
                          rating: widget.meta.rating),
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
