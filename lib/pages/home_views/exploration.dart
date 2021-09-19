import 'package:flutter/material.dart';
import 'package:spaced_trip_scheduler/widgets/base_view.dart';

class Exploration extends StatelessWidget {
  const Exploration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const BaseView(
      title: 'Explore',
      subTitle: 'Take a tour',
      body: Center(
        child: Text('Not Available yet...'),
      ),
    );
  }
}
