import 'package:flutter/material.dart';
import 'package:spaced_trip_scheduler/constants.dart';
import 'package:spaced_trip_scheduler/models/trip.dart';
import 'package:spaced_trip_scheduler/pages/payment_success_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:spaced_trip_scheduler/widgets/animation/faded_slide_transition.dart';
import 'package:spaced_trip_scheduler/widgets/sliding_panel.dart';
import 'dart:async';

class PaymentSlider extends StatefulWidget {
  final Trip trip;
  final Function(bool) onToggled;
  final AnimationController introController;
  const PaymentSlider({
    Key? key,
    required this.trip,
    required this.onToggled,
    required this.introController,
  }) : super(key: key);

  @override
  _PaymentSliderState createState() => _PaymentSliderState();
}

class _PaymentSliderState extends State<PaymentSlider> {
  late Animation<double> _paymentIntroAnimation;
  late Animation<double> _amountAnimation;
  late Animation<double> _faceAnimation;
  late Animation<double> _noteAnimation;
  late Timer timer;

  @override
  void initState() {
    super.initState();

    _paymentIntroAnimation = CurvedAnimation(
      parent: widget.introController,
      curve: Curves.ease,
    );
    _amountAnimation = CurvedAnimation(
      parent: widget.introController,
      curve: const Interval(0.2, 1.0, curve: Curves.ease),
    );
    _faceAnimation = CurvedAnimation(
      parent: widget.introController,
      curve: const Interval(0.4, 1.0, curve: Curves.ease),
    );
    _noteAnimation = CurvedAnimation(
      parent: widget.introController,
      curve: const Interval(0.6, 1.0, curve: Curves.ease),
    );
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
      onToggled: (isOpen) {
        widget.onToggled(isOpen);
        if (isOpen) {
          timer =
              Timer(const Duration(seconds: 6), () => _navigateToSuccessPage());
        } else {
          timer.cancel();
        }
      },
      maxHeight: MediaQuery.of(context).size.height - 350,
      color: kGreyBackgroundColor,
      child: SingleChildScrollView(
        child: Column(children: [
          FadedSlideTransition(
            animation: _paymentIntroAnimation,
            positionTween: Tween<Offset>(
              begin: const Offset(0.0, 10.0),
              end: Offset.zero,
            ),
            child: const Text('TOTAL'),
          ),
          const SizedBox(
            height: 16,
          ),
          FadedSlideTransition(
            animation: _amountAnimation,
            positionTween: Tween<Offset>(
              begin: const Offset(0.0, 10.0),
              end: Offset.zero,
            ),
            child: Text(
              widget.trip.getTripCost(),
              style: kHeadingStyle,
            ),
          ),
          FadedSlideTransition(
            animation: _faceAnimation,
            positionTween: Tween<Offset>(
              begin: const Offset(0.0, 10.0),
              end: Offset.zero,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 30,
              ),
              child: GestureDetector(
                child: Image.asset(
                  '$kIconsPath/animated_face.gif',
                  height: 120,
                ),
                onTap: () {
                  _navigateToSuccessPage();
                },
              ),
            ),
          ),
          FadedSlideTransition(
            animation: _noteAnimation,
            positionTween: Tween<Offset>(
              begin: const Offset(0.0, 10.0),
              end: Offset.zero,
            ),
            child: Text(
              'Scan face to Complete',
              style: kHeadingStyle.copyWith(fontSize: 25),
            ),
          ),
        ]),
      ),
    );
  }

  _navigateToSuccessPage() {
    timer.cancel();
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.bottomToTop,
            child: const PaymentSuccessPage()));
  }
}
