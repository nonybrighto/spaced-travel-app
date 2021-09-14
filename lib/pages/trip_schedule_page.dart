import 'package:flutter/material.dart';
import 'package:spaced_trip_scheduler/models/location.dart';
import 'package:spaced_trip_scheduler/models/trip.dart';
import 'package:spaced_trip_scheduler/pages/trip_schedule_views/location_time_slider.dart';
import 'package:spaced_trip_scheduler/pages/trip_schedule_views/passenger_slider.dart';
import 'package:spaced_trip_scheduler/pages/trip_schedule_views/payment_slider.dart';

import '../constants.dart';

class TripSchedulePage extends StatefulWidget {
  final Location location;
  final Rect buttonRect;
  const TripSchedulePage({
    Key? key,
    required this.location,
    required this.buttonRect,
  }) : super(key: key);

  @override
  State<TripSchedulePage> createState() => _TripSchedulePageState();
}

class _TripSchedulePageState extends State<TripSchedulePage>
    with TickerProviderStateMixin {
  bool showLocationTimeCompletedInfo = false;
  late Trip _trip;
  int _currentSlider = 0;
  late AnimationController _locationTimeIntroController;
  late AnimationController _passengarIntroController;
  late AnimationController _paymentIntroController;

  @override
  void initState() {
    super.initState();
    _trip = Trip(destination: widget.location);
    _locationTimeIntroController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _passengarIntroController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _paymentIntroController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  }

  @override
  void dispose() {
    _locationTimeIntroController.dispose();
    _passengarIntroController.dispose();
    _paymentIntroController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Hero(
            tag: 'location_image' + widget.location.title,
            child: Transform.scale(
              scale: 1.3,
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                widget.location.imageUrl,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
            child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              kBackgroundColor.withOpacity(0.5),
              kBackgroundColor.withOpacity(0.8),
            ],
            stops: const [0.0, 0.5],
          )),
        )),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'SCHEDULE TRIP',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
            ],
          ),
          body: Stack(
            children: [
              LocationTimeSlider(
                trip: _trip,
                introController: _locationTimeIntroController,
                buttonRect: widget.buttonRect,
                destinationLocation: widget.location,
                showCompletedInfo: _currentSlider != 0,
                onTripChanged: (trip) {
                  setState(() {
                    _trip = trip;
                  });
                },
              ),
              if (_trip.source != null)
                PassengerSlider(
                  trip: _trip,
                  introController: _passengarIntroController,
                  showCompletedInfo: _currentSlider == 2,
                  enabled: _timeDetailsCompleted(),
                  onTripChanged: (trip) {
                    setState(() {
                      _trip = trip;
                    });
                  },
                  onToggled: (isOpen) {
                    _changeCurrentSlider(isOpen);
                    if (isOpen) {
                      _passengarIntroController.forward();
                    } else {
                      _passengarIntroController.reverse();
                    }
                  },
                ),
              if (_currentSlider != 0)
                PaymentSlider(
                  trip: _trip,
                  introController: _paymentIntroController,
                  onToggled: (isOpen) {
                    _changeCurrentSlider(isOpen);
                    if (isOpen) {
                      _passengarIntroController.reverse();
                      _paymentIntroController.forward();
                    } else {
                      _passengarIntroController.forward();
                      _paymentIntroController.reverse();
                    }
                  },
                )
            ],
          ),
        ),
      ],
    );
  }

  bool _timeDetailsCompleted() =>
      _trip.startDate != null && _trip.depatureTime != null;

  _changeCurrentSlider(bool isSliderOpen) {
    setState(() {
      _currentSlider = isSliderOpen ? _currentSlider + 1 : _currentSlider - 1;
    });
  }
}
