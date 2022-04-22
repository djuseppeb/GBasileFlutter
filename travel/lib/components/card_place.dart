import 'package:flutter/material.dart';

import '../Pages/details_page.dart';

class CardPlace extends StatelessWidget {
  final String city;
  final String country;
  final String imgUrl;
  const CardPlace({Key? key, required this.city, required this.country, required this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: AspectRatio(
        aspectRatio: 1,
        child: GestureDetector(
          onTap: () => Navigator.of(context).push(
            //MaterialPageRoute(builder: (context) => DetailsPage(meta: null,))
          ),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1.2,
                      child: Container(
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: NetworkImage(imgUrl),
                            fit: BoxFit.cover
                          )
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(city, style: TextStyle(fontSize: 18),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.location_on, size: 14, color: Colors.blue,),
                          Text(country, style: TextStyle(fontSize: 14, color: Colors.blue))
                        ]
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
