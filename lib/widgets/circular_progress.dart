import 'package:flutter/material.dart';
import 'package:spaced_trip_scheduler/constants.dart';

class CircularProgress extends StatefulWidget {
  const CircularProgress({Key? key}) : super(key: key);

  @override
  _CircularProgressState createState() => _CircularProgressState();
}

class _CircularProgressState extends State<CircularProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressController;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )
      ..forward()
      ..repeat();
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _progressController,
        child: Image.asset(
          '$kIconsPath/progress.png',
          width: 200,
        ),
        builder: (context, child) {
          return Transform.rotate(
            angle: 3.14 * 2 * _progressController.value,
            child: child,
          );
        });
  }
}
