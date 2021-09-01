import 'package:flutter/material.dart';
import 'package:spaced_trip_scheduler/widgets/onboarding_wrapper.dart';

class RentalsView extends StatelessWidget {
  const RentalsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const OnboardingWrapper(
      background: 'building.png',
      iconName: 'location_pin.png',
      iconBackgroundName: 'location-pin.png',
      iconBackroundOffet: 45,
      titleLine1: 'Search and Compare',
      titleLine2: 'Vacation Rentals',
      message: 'Plan on staying longer? Book hotels, '
          'car rentals and other amazing deals '
          'across the universe.',
    );
  }
}
