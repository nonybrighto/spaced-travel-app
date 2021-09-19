import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:spaced_trip_scheduler/constants.dart';
import 'package:spaced_trip_scheduler/models/location.dart';
import 'package:spaced_trip_scheduler/pages/location_page.dart';
import 'package:spaced_trip_scheduler/widgets/location_card.dart';

class LocationsList extends StatelessWidget {
  final List<Location> locations;
  const LocationsList({Key? key, required this.locations}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int columnCount = 2;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: AnimationLimiter(
          child: GridView.count(
            crossAxisCount: columnCount,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 0.91,
            children: List.generate(
              locations.length,
              (int index) {
                return AnimationConfiguration.staggeredGrid(
                  position: index,
                  duration: const Duration(milliseconds: 600),
                  columnCount: columnCount,
                  child: SlideAnimation(
                    verticalOffset: 140,
                    child: FadeInAnimation(
                      child: LocationCard(
                          location: locations[index],
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LocationPage(
                                      location: locations[index],
                                    )));
                          }),
                    ),
                  ),
                );
              },
            ),
          ),
        ));
  }
}
