import 'package:flutter/material.dart';
import 'package:spaced_trip_scheduler/constants.dart';
import 'package:spaced_trip_scheduler/widgets/number_picker.dart';

class PassengerSlider extends StatefulWidget {
  final AnimationController controller;
  final bool activate;
  final VoidCallback onOpened;
  const PassengerSlider({
    Key? key,
    required this.controller,
    required this.activate,
    required this.onOpened,
  }) : super(key: key);

  @override
  _PassengerSliderState createState() => _PassengerSliderState();
}

class _PassengerSliderState extends State<PassengerSlider> {
  final Tween<Offset> _slideTween =
      Tween(begin: const Offset(0, 1), end: const Offset(0, 0));

  int? _numberOfAdults = 1;
  bool _showChildSelection = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideTween.animate(widget.controller),
      child: DraggableScrollableSheet(
          expand: true,
          initialChildSize: 0.7,
          maxChildSize: 0.7,
          minChildSize: 0.2,
          builder: (context, controller) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                  color: widget.activate
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(35))),
              padding: const EdgeInsets.all(30),
              child: Stack(
                children: [
                  Positioned.fill(
                    top: 25,
                    child: SingleChildScrollView(
                        child: Column(children: [
                      const Text(
                        'How many Adults?',
                        style: kHeadingStyle,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        '12 YEARS +',
                        style: TextStyle(fontSize: 14),
                      ),
                      NumberPicker(
                        selectedValue: _numberOfAdults,
                        isLarge: !_showChildSelection,
                        onValuePicked: (value) {
                          setState(() {
                            _numberOfAdults = value;
                          });
                        },
                      ),
                      Checkbox(
                          value: _showChildSelection,
                          onChanged: (show) {
                            setState(() {
                              _showChildSelection = show!;
                            });
                          }),
                      if (_showChildSelection)
                        NumberPicker(
                          selectedValue: _numberOfAdults,
                          isLarge: !_showChildSelection,
                          onValuePicked: (value) {
                            setState(() {
                              _numberOfAdults = value;
                            });
                          },
                        ),
                    ])),
                  ),
                  const Align(
                      alignment: Alignment.topCenter, child: Text('SEATS')),
                  Positioned(
                    right: 0,
                    top: -10,
                    child: IconButton(
                      icon: const Icon(
                        Icons.expand_less,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        widget.controller.forward();
                        widget.onOpened();
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
