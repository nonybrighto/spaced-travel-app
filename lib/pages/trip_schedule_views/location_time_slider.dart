import 'package:flutter/material.dart';
import 'package:spaced_trip_scheduler/constants.dart';
import 'package:spaced_trip_scheduler/models/location.dart';
import 'package:spaced_trip_scheduler/models/trip.dart';
import 'package:spaced_trip_scheduler/widgets/animation/button_fill_transition.dart';
import 'package:spaced_trip_scheduler/widgets/animation/faded_slide_transition.dart';
import 'package:spaced_trip_scheduler/widgets/app_button.dart';
import 'package:spaced_trip_scheduler/widgets/calendar.dart';
import 'package:spaced_trip_scheduler/widgets/location_info_item.dart';
import 'package:spaced_trip_scheduler/widgets/circular_progress.dart';

class LocationTimeSlider extends StatefulWidget {
  final Trip trip;
  final Location destinationLocation;
  final Function(Trip) onTripChanged;
  final bool showCompletedInfo;
  final Rect buttonRect;
  final AnimationController introController;
  const LocationTimeSlider({
    Key? key,
    required this.destinationLocation,
    required this.showCompletedInfo,
    required this.trip,
    required this.onTripChanged,
    required this.buttonRect,
    required this.introController
  }) : super(key: key);

  @override
  _LocationTimeSliderState createState() => _LocationTimeSliderState();
}

class _LocationTimeSliderState extends State<LocationTimeSlider>
    with SingleTickerProviderStateMixin {
  bool _searchingForCurrentLocation = false;
  late Trip _trip;
  late AnimationController _containerController;
  late Animation<double> _locationIntroAnimation;
  late Animation<double> _calendarTitleIntroAnimation;
  late Animation<double> _calendarTimeIntroAnimation;

  List<String> depatureTimes = [
    '5:00 AM',
    '12:30 PM',
    '6:00 PM',
    '9:30 PM',
  ];

  @override
  void initState() {
    super.initState();
    _trip = widget.trip;
    _containerController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600))
      ..forward();

    _locationIntroAnimation = CurvedAnimation(
      parent: widget.introController,
      curve: Curves.ease,
    );
    _calendarTitleIntroAnimation = CurvedAnimation(
      parent: widget.introController,
      curve: const Interval(0.2, 1.0, curve: Curves.ease),
    );
    _calendarTimeIntroAnimation = CurvedAnimation(
      parent: widget.introController,
      curve: const Interval(0.4, 1.0, curve: Curves.ease),
    );
    _searchCurrentLocation();
  }

  @override
  void dispose() {
    _containerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ButtonFillTransition(
      buttonRect: widget.buttonRect,
      animation: _containerController,
      child: _searchingForCurrentLocation
          ? _buildLocationSearch()
          : SingleChildScrollView(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(kDefaultPadding),
                      child: _buildLocationDisplay(),
                    ),
                    const Divider(
                      height: 1,
                      thickness: 2,
                      color: Color(0xff2b2d2f),
                    ),
                    AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) {
                          return FadedSlideTransition(
                            animation: animation,
                            positionTween: Tween<Offset>(
                              begin: const Offset(0.0, 1.0),
                              end: Offset.zero,
                            ),
                            child: child,
                          );
                        },
                        child: widget.showCompletedInfo
                            ? _displayCompletedInfo('completed')
                            : _displaySelectionInfo('selection'))
                  ]),
            ),
    );
  }

  Widget _buildLocationDisplay() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return FadedSlideTransition(
          animation: animation,
          positionTween: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ),
          child: child,
        );
      },
      child: widget.showCompletedInfo
          ? _buildLocation(Axis.horizontal)
          : FadedSlideTransition(
              animation: _locationIntroAnimation,
              positionTween: Tween<Offset>(
                begin: const Offset(0.0, 1.0),
                end: Offset.zero,
              ),
              child: _buildLocation(Axis.vertical),
            ),
    );
  }

  _displayCompletedInfo(String key) {
    return Column(key: ValueKey(key), children: [
      Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTimeInfo('DATE: ', 'Feb 15 - Feb 24'),
            _buildTimeInfo('TIME: ', '12:20 PM'),
          ],
        ),
      )
    ]);
  }

  _displaySelectionInfo(String key) {
    return Column(key: ValueKey(key), children: [
      FadedSlideTransition(
        animation: _calendarTitleIntroAnimation,
        positionTween: Tween<Offset>(
          begin: const Offset(0.0, 3.0),
          end: Offset.zero,
        ),
        child: const Padding(
          padding: EdgeInsets.only(top: kDefaultPadding),
          child: Text(
            'Trip Calendar',
            style: kHeadingStyle,
          ),
        ),
      ),
      FadedSlideTransition(
        positionTween: Tween<Offset>(
          begin: const Offset(0.0, 0.6),
          end: Offset.zero,
        ),
        animation: _calendarTimeIntroAnimation,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding, vertical: 5),
          child: Column(
            children: [
              Calendar(
                startDate: widget.trip.startDate,
                endDate: widget.trip.endDate,
                onRangeChanged: (startDate, endDate) {
                  setState(() {
                    _trip.startDate = startDate;
                    _trip.endDate = endDate;
                    widget.onTripChanged(_trip);
                  });
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  'DEPATURE TIME',
                  style: TextStyle(fontSize: 13),
                ),
              ),
              _buildDepatureTimeSelector(),
            ],
          ),
        ),
      )
    ]);
  }

  _buildDepatureTimeSelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (String time in depatureTimes)
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: AppButton(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(time),
                  ),
                  color: _trip.depatureTime == time
                      ? Theme.of(context).primaryColor
                      : kGreyBackgroundColor,
                  onPressed: () {
                    setState(() {
                      _trip.depatureTime = time;
                      widget.onTripChanged(_trip);
                    });
                  }),
            )
        ],
      ),
    );
  }

  _buildTimeInfo(String title, String info) {
    return RichText(
        text: TextSpan(
            text: title,
            style: const TextStyle(color: kNoteTextColorDarker),
            children: [
          TextSpan(
              text: info.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
              )),
        ]));
  }

  _buildLocationSearch() {
    return Center(
      child: SingleChildScrollView(
        //adding a scrollview prevents overflow when the panel grows
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgress(),
            const SizedBox(height: 25),
            Text(
              'Finding your location',
              style: kHeadingStyle.copyWith(fontSize: 30),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 2 / 4,
              child: const Text(
                'One moment while we get your location',
                textAlign: TextAlign.center,
                style: TextStyle(color: kNoteTextColorDarker, fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLocation(Axis axis) {
    int flex = axis == Axis.horizontal ? 1 : 0;
    return Flex(
      direction: axis,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: flex,
          child: LocationInfoItem(
              location: _trip.source!,
              icon: Column(
                children: [
                  Image.asset('$kIconsPath/location_from_circle.png'),
                  SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.0, 1.5),
                        end: Offset.zero,
                      ).animate(_locationIntroAnimation),
                      child: Image.asset('$kIconsPath/location_from_line.png')),
                ],
              )),
        ),
        const SizedBox(
          height: 10,
          width: 30,
        ),
        Expanded(
          flex: flex,
          child: LocationInfoItem(
            location: widget.destinationLocation,
            isDestination: true,
            icon: Image.asset('$kIconsPath/location_from_circle.png'),
          ),
        )
      ],
    );
  }

  _searchCurrentLocation() {
    _searchingForCurrentLocation = true;
    Future.delayed(const Duration(seconds: 3)).then((value) {
      setState(() {
        _searchingForCurrentLocation = false;
        _trip.source = Location(
            title: 'Lagos',
            place: 'LOS',
            country: 'Nigeria',
            imageUrl: '$kImagesPath/simone-hutsch-699861-unsplash.jpg',
            price: 500,
            description: 'My place');
        widget.onTripChanged(_trip);
        widget.introController.forward();
      });
    });
  }
}
