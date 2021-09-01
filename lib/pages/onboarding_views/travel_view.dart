import 'package:flutter/material.dart';
import 'package:spaced_trip_scheduler/widgets/onboarding_wrapper.dart';

class TravelView extends StatelessWidget {
  const TravelView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const OnboardingWrapper(
      background: 'solar.png',
      iconName: 'red_rocket.png',
      iconBackgroundName: 'rocket.png',
      iconBackroundOffet: 70,
      titleLine1: 'Discover Places in',
      titleLine2: 'Virtual Reality',
      message: 'Travel to outworld universes from our '
          'galaxy and beyound. See new places '
          'and feel the adventure.',
    );
  }
}
