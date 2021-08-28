import 'package:flutter/material.dart';
import 'package:spaced_trip_scheduler/constants.dart';
import 'package:spaced_trip_scheduler/models/location.dart';

class LocationInfoItem extends StatelessWidget {
  final Location location;
  final bool isDestination;
  final Widget icon;
  const LocationInfoItem({
    Key? key,
    required this.location,
    this.isDestination = false,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String directionString = isDestination ? 'to' : 'from';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: icon,
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                    text: '${location.title}, ',
                    children: [
                      TextSpan(
                        text: location.place,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    ],
                    style: kHeadingStyle.copyWith(fontSize: 24)),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '$directionString ${location.country}'.toUpperCase(),
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: kNoteTextColorDarker,
                  fontSize: 15,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
