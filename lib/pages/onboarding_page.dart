import 'package:flutter/material.dart';
import 'package:spaced_trip_scheduler/pages/home_page.dart';
import 'package:spaced_trip_scheduler/pages/onboarding_views/profile_view.dart';
import 'package:spaced_trip_scheduler/widgets/animated_stacked_index.dart';
import 'package:spaced_trip_scheduler/widgets/dot_indicator.dart';
import 'package:spaced_trip_scheduler/widgets/onboarding_wrapper.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

const List<Widget> onboardingScreens = [
  ProfileView(),
  OnboardingWrapper(
    background: 'vr-curve.png',
    iconName: 'colored_vr_icon.png',
    iconBackgroundName: 'vr-icon-bg.png',
    titleLine1: 'Discover Places in',
    titleLine2: 'Virtual Reality',
    message: 'Visit many worlds and universes from '
        'your couch using your VR headset. '
        'Experience the real stuff.',
  ),
  OnboardingWrapper(
    background: 'vr-glasses.png',
    iconName: 'colored_vr_icon.png',
    iconBackgroundName: 'vr-icon-bg.png',
    titleLine1: 'Discover Places in',
    titleLine2: 'Virtual Reality',
    message: 'Visit many worlds and universes from '
        'your couch using your VR headset. '
        'Experience the real stuff.',
  ),
  OnboardingWrapper(
    background: 'solar.png',
    iconName: 'red_rocket.png',
    iconBackgroundName: 'rocket.png',
    iconBackroundOffet: 70,
    titleLine1: 'Discover Places in',
    titleLine2: 'Virtual Reality',
    message: 'Travel to outworld universes from our '
        'galaxy and beyound. See new places '
        'and feel the adventure.',
  ),
  OnboardingWrapper(
    background: 'building.png',
    iconName: 'navigation_icon.png',
    iconBackgroundName: 'location-pin.png',
    iconBackroundOffet: 45,
    titleLine1: 'Search and Compare',
    titleLine2: 'Vacation Rentals',
    message: 'Plan on staying longer? Book hotels, '
        'car rentals and other amazing deals '
        'across the universe.',
  )
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
