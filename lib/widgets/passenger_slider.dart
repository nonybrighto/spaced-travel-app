import 'package:flutter/material.dart';
import 'package:spaced_trip_scheduler/constants.dart';

class PassengerSlider extends StatefulWidget {
  final AnimationController controller;
  final bool activate;
  const PassengerSlider({
    Key? key,
    required this.controller,
    required this.activate,
  }) : super(key: key);

  @override
  _PassengerSliderState createState() => _PassengerSliderState();
}

class _PassengerSliderState extends State<PassengerSlider> {
  final Tween<Offset> _slideTween =
      Tween(begin: const Offset(0, 1), end: const Offset(0, 0));
  late Animation<Color?> _backgroundColorTween;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _backgroundColorTween =
        ColorTween(begin: Theme.of(context).primaryColor, end: kBackgroundColor)
            .animate(widget.controller);
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideTween.animate(widget.controller),
      child: DraggableScrollableSheet(
          expand: true,
          initialChildSize: 0.1,
          maxChildSize: 0.7,
          minChildSize: 0,
          builder: (context, _) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                  color: widget.activate
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(35))),
              padding: const EdgeInsets.all(30),
              child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {
                        print('Clicked');
                      },
                      child: Text('Book',
                          style: TextStyle(
                            color: Colors.red,
                          )),
                    )
                  ]),
            );
          }),
    );
  }
}
