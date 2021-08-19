import 'package:flutter/material.dart';
import 'package:spaced_trip_scheduler/models/category.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  const CategoryCard({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(
                0.9), //current images don't with much tint cuz they re dark
            BlendMode.dstATop,
          ),
          image: AssetImage(category.imageUrl),
          fit: BoxFit.cover,
        )),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            child: Center(
                child: Text(
              category.name,
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w500,
              ),
            )),
            onTap: () {},
          ),
        ),
      ),
    );
  }
}
