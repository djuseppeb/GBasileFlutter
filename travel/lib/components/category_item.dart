import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String categoryName;
  final IconData categoryIcon;
  final Color categoryColor;
  final bool hasPadding;
  const CategoryItem(
      {Key? key,
      required this.categoryName,
      required this.categoryIcon,
      required this.categoryColor,
      this.hasPadding = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: hasPadding
          ? const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0)
          : const EdgeInsets.only(top: 4.0, bottom: 4, left: 8.0, right: 0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    categoryIcon,
                    color: Colors.white,
                  ),
                ),
                decoration: BoxDecoration(
                    color: categoryColor,
                    borderRadius: BorderRadius.circular(6)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  categoryName,
                  style: const TextStyle(fontSize: 14),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
