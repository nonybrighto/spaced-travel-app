import 'package:flutter/material.dart';
import 'package:spaced_trip_scheduler/constants.dart';
import 'package:spaced_trip_scheduler/pages/onboarding_views/discovery_view.dart';
import 'package:spaced_trip_scheduler/pages/onboarding_views/profile_view.dart';
import 'package:spaced_trip_scheduler/widgets/animated_stacked_index.dart';

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
          DiscoveryView(),
          ProfileView(),
        ]),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            alignment: Alignment.center,
            height: kOnboardingIndicatorHeight,
            child: GestureDetector(
              child: const Text('Skip'),
              onTap: () {
                setState(() {
                  index++;
                });
              },
            ),
          ),
        )
      ],
    ));
  }
}
