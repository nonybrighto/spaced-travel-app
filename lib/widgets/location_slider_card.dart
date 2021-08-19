import 'package:flutter/material.dart';
import 'package:spaced_trip_scheduler/constants.dart';
import 'package:spaced_trip_scheduler/models/location.dart';

class LocationSliderCard extends StatelessWidget {
  final Location location;
  const LocationSliderCard({Key? key, required this.location})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const spacer = SizedBox(height: 2);
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(13)),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(location.imageUrl),
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
                          color: Color(0xffafb6c1),
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
                    color: kAccentColor,
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
              onTap: () {
                print('stop clicked');
              },
            ),
          )
        ],
      ),
    );
  }
}
