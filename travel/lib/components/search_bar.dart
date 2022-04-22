import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Search",
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder()
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 6),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: Colors.lightBlue.shade100,
              borderRadius: BorderRadius.circular(6)
          ),
          child: IconButton(onPressed: () => print("cerco cose"), icon: const Icon(Icons.filter_list, color: Colors.blue,),),)
      ],
    );
  }
}
