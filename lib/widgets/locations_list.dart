import 'package:flutter/material.dart';
import 'package:spaced_trip_scheduler/constants.dart';
import 'package:spaced_trip_scheduler/models/location.dart';
import 'package:spaced_trip_scheduler/pages/location_page.dart';
import 'package:spaced_trip_scheduler/widgets/location_card.dart';

class LocationsList extends StatelessWidget {
  final List<Location> locations;
  const LocationsList({Key? key, required this.locations}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 0.91),
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return LocationCard(
              location: locations[index],
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LocationPage(
                          location: locations[index],
                        )));
              });
        },
      ),
    );
  }
}
