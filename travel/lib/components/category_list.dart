import 'package:flutter/material.dart';
import 'package:travel/models/interessi.dart';
import 'package:travel/components/category_item.dart';

class CategoryList extends StatelessWidget {
  final List<Interessi> interessiSelezionati;
  final Function(Interessi?) callback;
  const CategoryList(this.interessiSelezionati, this.callback, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Category", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: Interessi.values.length,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Row(
                  children: [
                    CategoryItem(
                        null,
                        interessiSelezionati.isEmpty,
                        callback,
                        categoryName: "all",
                        categoryIcon: Icons.grid_view_rounded,
                        categoryColor: Colors.blueAccent.shade700),
                    CategoryItem(
                      Interessi.values[index],
                      interessiSelezionati.contains(Interessi.values[index]),
                      callback,
                    )
                  ],
                );
              }
              if (index == Interessi.values.length-1) {
                return CategoryItem(
                  Interessi.values[index],
                  interessiSelezionati.contains(Interessi.values[index]),
                  callback,);
              } else {
                return CategoryItem(
                  Interessi.values[index],
                  interessiSelezionati.contains(Interessi.values[index]),
                  callback,
                  hasPadding: false,
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
