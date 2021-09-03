import 'package:flutter/material.dart';
import 'package:spaced_trip_scheduler/pages/home_page.dart';
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

const List<Widget> onboardingScreens = [
  ProfileView(),
  DiscoveryView(),
  SecondDiscoveryView(),
  TravelView(),
  RentalsView(),
];

class _OnboardingState extends State<Onboarding> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    const buttonStyle = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: Color(0xffafb6c1),
    );
    return Scaffold(
        body: Stack(
      children: [
        AnimatedIndexedStack(index: index, children: onboardingScreens),
        Positioned(
          right: 10,
          top: 50,
          child: TextButton(
            child: const Text(
              'Skip',
              style: buttonStyle,
            ),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            alignment: Alignment.center,
            height: 100,
            child: Column(
              children: [
                DotIndicator(
                  count: onboardingScreens.length,
                  currentIndex: index,
                ),
                const SizedBox(
                  height: 10,
                ),
                (index != onboardingScreens.length - 1)
                    ? TextButton(
                        child: const Text(
                          'Next',
                          style: buttonStyle,
                        ),
                        onPressed: () {
                          setState(() {
                            index++;
                          });
                        },
                      )
                    : TextButton(
                        child: const Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const HomePage()));
                        },
                      )
              ],
            ),
          ),
        )
      ],
    ));
  }
}
