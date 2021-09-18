import 'package:flutter/material.dart';
import 'package:spaced_trip_scheduler/constants.dart';
import 'package:spaced_trip_scheduler/models/location.dart';

class LocationCard extends StatelessWidget {
  final Location location;
  final VoidCallback onTap;
  const LocationCard({
    Key? key,
    required this.location,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const spacer = SizedBox(height: 2);
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(13)),
      child: Stack(
        children: [
          Hero(
              tag: 'location_image' + location.title,
              child: Image.asset(
                location.imageUrl,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.fill,
              )),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                kBackgroundColor.withOpacity(0.1),
                kBackgroundColor.withOpacity(0.7),
              ],
              stops: const [0.0, 0.4, 0.7],
            )),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: kPrimaryColor,
              ),
              child: Row(
                children: [
                  Image.asset(
                    '$kIconsPath/rocket.png',
                    height: 15,
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Text(
                    location.getFormattedPrice(),
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            '$kIconsPath/vr_icon.png',
                            height: 10,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'VR',
                            style: TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                      spacer,
                      Text(
                        location.title,
                        style: kHeadingStyle.copyWith(fontSize: 23),
                      ),
                      spacer,
                      Text(
                        location.place.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 13,
                          color: kNoteTextColorDarker,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              child: Container(),
              onTap: onTap,
            ),
          )
        ],
      ),
    );
  }
}
