import 'package:flutter/material.dart';
import 'package:spaced_trip_scheduler/models/location.dart';
import 'package:spaced_trip_scheduler/models/trip.dart';
import 'package:spaced_trip_scheduler/pages/trip_schedule_views/location_time_slider.dart';
import 'package:spaced_trip_scheduler/pages/trip_schedule_views/passenger_slider.dart';
import 'package:spaced_trip_scheduler/pages/trip_schedule_views/payment_slider.dart';

import '../constants.dart';

class TripSchedulePage extends StatefulWidget {
  final Location location;
  const TripSchedulePage({
    Key? key,
    required this.location,
  }) : super(key: key);

  @override
  State<TripSchedulePage> createState() => _TripSchedulePageState();
}

class _TripSchedulePageState extends State<TripSchedulePage>
    with TickerProviderStateMixin {
  bool showLocationTimeCompletedInfo = false;
  late Trip _trip;
  int _currentSlider = 0;

  @override
  void initState() {
    super.initState();
    _trip = Trip(destination: widget.location);
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
            centerTitle: true,
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
                  showCompletedInfo: _currentSlider == 2,
                  enabled: _timeDetailsCompleted(),
                  onTripChanged: (trip) {
                    setState(() {
                      _trip = trip;
                    });
                  },
                  onToggled: (isOpen) {
                    _changeCurrentSlider(isOpen);
                  },
                ),
              if (_currentSlider != 0)
                PaymentSlider(
                  trip: _trip,
                  onToggled: (isOpen) {
                    _changeCurrentSlider(isOpen);
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
