import 'package:flutter/material.dart';
import 'package:spaced_trip_scheduler/constants.dart';

class LocationTimeSlider extends StatefulWidget {
  final AnimationController controller;
  final VoidCallback onCompleted;
  const LocationTimeSlider({
    Key? key,
    required this.controller,
    required this.onCompleted,
  }) : super(key: key);

  @override
  _LocationTimeSliderState createState() => _LocationTimeSliderState();
}

class _LocationTimeSliderState extends State<LocationTimeSlider> {
  final Tween<Offset> _slideTween =
      Tween(begin: const Offset(0, 1), end: const Offset(0, 0));
  late Animation<Color?> _backgroundColorTween;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _backgroundColorTween =
        ColorTween(begin: Theme.of(context).primaryColor, end: kBackgroundColor)
            .animate(widget.controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: widget.controller,
        builder: (context, child) {
          return SlideTransition(
            position: _slideTween.animate(widget.controller),
            child: DraggableScrollableSheet(
                expand: true,
                initialChildSize: 0.97,
                maxChildSize: 0.97,
                builder: (context, _) {
                  return Container(
                    decoration: BoxDecoration(
                        color: _backgroundColorTween.value,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(35))),
                    padding: const EdgeInsets.all(30),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                              onPressed: () {
                                widget.onCompleted();
                              },
                              child: Text('Completed')),
                        ]),
                  );
                }),
          );
        });
  }
}
