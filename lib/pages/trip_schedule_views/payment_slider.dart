import 'package:flutter/material.dart';
import 'package:spaced_trip_scheduler/constants.dart';
import 'package:spaced_trip_scheduler/models/trip.dart';
import 'package:spaced_trip_scheduler/pages/payment_success_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:spaced_trip_scheduler/widgets/sliding_panel.dart';

class PaymentSlider extends StatefulWidget {
  final Trip trip;
  final Function(bool) onToggled;
  const PaymentSlider({
    Key? key,
    required this.trip,
    required this.onToggled,
  }) : super(key: key);

  @override
  _PaymentSliderState createState() => _PaymentSliderState();
}

class _PaymentSliderState extends State<PaymentSlider> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SlidingPanel(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('$kIconsPath/apple.png'),
          const SizedBox(
            width: 10,
          ),
          const Text('PAY')
        ],
      ),
      onToggled: widget.onToggled,
      maxHeight: MediaQuery.of(context).size.height - 350,
      color: kGreyBackgroundColor,
      child: SingleChildScrollView(
        child: Column(children: [
          const Text('TOTAL'),
          const SizedBox(
            height: 16,
          ),
          Text(
            widget.trip.getTripCost(),
            style: kHeadingStyle,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 30,
            ),
            child: GestureDetector(
              child: Image.asset(
                '$kIconsPath/animated_face.gif',
                height: 120,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.bottomToTop,
                        child: const PaymentSuccessPage()));
              },
            ),
          ),
          Text(
            'Scan face to Complete',
            style: kHeadingStyle.copyWith(fontSize: 25),
          ),
        ]),
      ),
    );
  }
}
