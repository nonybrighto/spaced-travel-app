import 'package:flutter/material.dart';
import 'package:spaced_trip_scheduler/constants.dart';
import 'package:spaced_trip_scheduler/pages/onboarding_views/discovery_view.dart';
import 'package:spaced_trip_scheduler/pages/onboarding_views/profile_view.dart';
import 'package:spaced_trip_scheduler/pages/onboarding_views/rentals_view.dart';
import 'package:spaced_trip_scheduler/pages/onboarding_views/second_discovery_view.dart';
import 'package:spaced_trip_scheduler/pages/onboarding_views/travel_view.dart';
import 'package:spaced_trip_scheduler/widgets/animated_stacked_index.dart';
import 'package:spaced_trip_scheduler/widgets/dot_indicator.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        AnimatedIndexedStack(index: index, children: const [
          ProfileView(),
          DiscoveryView(),
          SecondDiscoveryView(),
          TravelView(),
          RentalsView(),
        ]),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            alignment: Alignment.center,
            height: kOnboardingIndicatorHeight,
            child: Column(
              children: [
                DotIndicator(
                  count: 5,
                  currentIndex: index,
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  child: const Text('Next'),
                  onTap: () {
                    setState(() {
                      index++;
                    });
                  },
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
