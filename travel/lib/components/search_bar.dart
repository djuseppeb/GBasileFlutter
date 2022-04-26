import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final bool isHomePage;
  final Function(String)? callback;
  const SearchBar({Key? key, this.isHomePage=false, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: TextField(
              onTap: isHomePage ? () {
                FocusScope.of(context).unfocus();
                Navigator.of(context).pushNamed("/search");
              } : null,
              onChanged: callback,
              readOnly: isHomePage,
              autofocus: !isHomePage,
              decoration: const InputDecoration(
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
          child: IconButton(
            onPressed: () {
              if(Scaffold.of(context).hasEndDrawer){
                Scaffold.of(context).openEndDrawer();
              }
            },
            icon: const Icon(Icons.filter_list, color: Colors.blue,),),
        )
      ],
    );
  }
}
