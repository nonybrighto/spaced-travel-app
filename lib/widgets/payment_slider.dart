import 'package:flutter/material.dart';
import 'package:spaced_trip_scheduler/constants.dart';

class PaymentSlider extends StatefulWidget {
  final AnimationController controller;
  final VoidCallback onOpened;
  const PaymentSlider({
    Key? key,
    required this.controller,
    required this.onOpened,
  }) : super(key: key);

  @override
  _PaymentSliderState createState() => _PaymentSliderState();
}

class _PaymentSliderState extends State<PaymentSlider> {
  final Tween<Offset> _slideTween =
      Tween(begin: const Offset(0, 1), end: const Offset(0, 0));

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
          initialChildSize: 1,
          maxChildSize: 1,
          minChildSize: 0.4,
          builder: (context, controller) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: const BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(35))),
              padding: const EdgeInsets.all(30),
              child: Stack(
                children: [
                  Positioned.fill(
                    top: 25,
                    child: SingleChildScrollView(
                        controller: controller,
                        child: Column(children: const [
                          Text('Hello'),
                        ])),
                  ),
                  Align(
                      alignment: Alignment.topCenter,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset('$kIconsPath/apple.png'),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text('PAY')
                        ],
                      )),
                  Positioned(
                    right: 0,
                    top: -10,
                    child: IconButton(
                      icon: const Icon(
                        Icons.expand_less,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        widget.controller.animateTo(0.63);
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
