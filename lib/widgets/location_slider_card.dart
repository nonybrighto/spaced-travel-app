import 'package:flutter/material.dart';
import 'package:spaced_trip_scheduler/constants.dart';
import 'package:spaced_trip_scheduler/models/location.dart';

class LocationSliderCard extends StatelessWidget {
  final double offset;
  final Location location;
  final VoidCallback onTap;
  const LocationSliderCard({
    Key? key,
    required this.offset,
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
          Positioned(
            left: -offset,
            right: 0,
            top: -offset,
            bottom: 0,
            child: Hero(
                tag: 'location_image' + location.title,
                child: Image.asset(
                  location.imageUrl,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )),
          ),
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
                          Image.asset('$kIconsPath/vr_icon.png'),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text('VR')
                        ],
                      ),
                      spacer,
                      Text(
                        location.title,
                        style: kHeadingStyle,
                      ),
                      spacer,
                      Text(
                        location.place.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: kNoteTextColorDarker,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: kPrimaryColor,
                  ),
                  child: Row(
                    children: [
                      Image.asset('$kIconsPath/rocket.png'),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(location.getFormattedPrice())
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Image.asset('ss')
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
