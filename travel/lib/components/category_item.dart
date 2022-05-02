import 'package:flutter/material.dart';

import 'package:travel/models/interessi.dart';

class CategoryItem extends StatelessWidget {
  final Interessi? interesse;
  final bool attivo;
  final Function(Interessi?) callback;

  final String? categoryName;
  final IconData? categoryIcon;
  final Color? categoryColor;
  final bool? hasPadding;

  const CategoryItem(this.interesse,
      this.attivo,
      this.callback,
      {Key? key,
        this.categoryName,
        this.categoryIcon,
        this.categoryColor,
        this.hasPadding = true,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback(interesse);
      },
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    interesse?.icon ?? categoryIcon,
                    color: attivo ? Colors.white : (interesse?.color ??
                        categoryColor),
                  ),
                ),
                decoration: BoxDecoration(
                    color: attivo ? (interesse?.color ?? categoryColor) : Colors
                        .white,
                    borderRadius: BorderRadius.circular(6)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  interesse?.name ?? categoryName ?? '',
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
