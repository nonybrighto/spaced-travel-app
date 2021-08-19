import 'package:flutter/material.dart';
import 'package:spaced_trip_scheduler/models/location.dart';

class LocationSliderCard extends StatelessWidget {
  final Location location;
  const LocationSliderCard({Key? key, required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(location.imageUrl))
          ),
        ),
        Image.asset('ss')
      ],
    );
  }
}
