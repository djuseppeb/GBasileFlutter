import 'package:flutter/material.dart';
import 'package:travel/models/interessi.dart';
import 'package:travel/components/category_item.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Category", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
        SizedBox(
          height: 100,
          /*child: ListView(
              scrollDirection: Axis.horizontal,
              children: [CategoryItem(categoryName: "all", categoryIcon: Icons.grid_view_rounded, categoryColor: Colors.blue.shade700)] + Interessi.values.map(
                      (interesse) => CategoryItem(categoryName: interesse.name, categoryIcon: interesse.icon, categoryColor: interesse.color)
              ).toList()
          ),*/
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: Interessi.values.length,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Row(
                  children: [
                    CategoryItem(
                        categoryName: "all",
                        categoryIcon: Icons.grid_view_rounded,
                        categoryColor: Colors.blueAccent.shade700),
                    CategoryItem(
                        categoryName: Interessi.values[index].name,
                        categoryIcon: Interessi.values[index].icon,
                        categoryColor: Interessi.values[index].color)
                  ],
                );
              }
              if (index == Interessi.values.length-1) {
                return CategoryItem(
                    categoryName: Interessi.values[index].name,
                    categoryIcon: Interessi.values[index].icon,
                    categoryColor: Interessi.values[index].color);
              } else {
                return CategoryItem(
                  categoryName: Interessi.values[index].name,
                  categoryIcon: Interessi.values[index].icon,
                  categoryColor: Interessi.values[index].color,
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
