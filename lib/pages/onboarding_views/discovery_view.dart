import 'package:flutter/material.dart';
import 'package:spaced_trip_scheduler/widgets/onboarding_wrapper.dart';

class DiscoveryView extends StatelessWidget {
  const DiscoveryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const OnboardingWrapper(
      background: 'vr-curve.png',
      iconName: 'colored_vr_icon.png',
      iconBackgroundName: 'vr-icon-bg.png',
      titleLine1: 'Discover Places in',
      titleLine2: 'Virtual Reality',
      message: 'Visit many worlds and universes from '
          'your couch using your VR headset. '
          'Experience the real stuff.',
    );
  }
}
