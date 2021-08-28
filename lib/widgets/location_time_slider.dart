import 'package:flutter/material.dart';
import 'package:spaced_trip_scheduler/constants.dart';
import 'package:spaced_trip_scheduler/models/location.dart';
import 'package:spaced_trip_scheduler/widgets/app_button.dart';
import 'package:spaced_trip_scheduler/widgets/location_info_item.dart';

class LocationTimeSlider extends StatefulWidget {
  final AnimationController controller;
  final VoidCallback onCompleted;
  final VoidCallback onSearchCompleted;
  final Location destinationLocation;
  final bool showCompletedInfo;
  const LocationTimeSlider({
    Key? key,
    required this.controller,
    required this.onCompleted,
    required this.destinationLocation,
    required this.showCompletedInfo,
    required this.onSearchCompleted,
  }) : super(key: key);

  @override
  _LocationTimeSliderState createState() => _LocationTimeSliderState();
}

class _LocationTimeSliderState extends State<LocationTimeSlider> {
  final Tween<Offset> _slideTween =
      Tween(begin: const Offset(0, 1), end: const Offset(0, 0));
  late Animation<Color?> _backgroundColorTween;
  bool _searchingForCurrentLocation = false;
  late Location _currentLocation;
  String selectedDepatureTime = '';

  @override
  void initState() {
    super.initState();

    _searchCurrentLocation();
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
        child: _searchingForCurrentLocation
            ? _buildLocationSearch()
            : SingleChildScrollView(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // _buildLocation(Axis.vertical),
                      widget.showCompletedInfo
                          ? _displayCompletedInfo()
                          : _displaySelectionInfo()
                    ]),
              ),
        animation: widget.controller,
        builder: (context, child) {
          return SlideTransition(
            position: _slideTween.animate(widget.controller),
            child: DraggableScrollableSheet(
                expand: true,
                initialChildSize: 0.99,
                maxChildSize: 0.99,
                builder: (context, _) {
                  return Container(
                    decoration: BoxDecoration(
                        color: _backgroundColorTween.value,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(35))),
                    child: child,
                  );
                }),
          );
        });
  }

  _displayCompletedInfo() {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: _buildLocation(Axis.horizontal),
      ),
      const Divider(
        height: 30,
        thickness: 2,
        color: Color(0xff2b2d2f),
      ),
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

  _displaySelectionInfo() {
    List<String> depatureTimes = [
      '5:00 AM',
      '12:30 PM',
      '6:00 PM',
      '9:30 PM',
    ];
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: _buildLocation(Axis.vertical),
      ),
      const Divider(
        height: 30,
        thickness: 2,
        color: Color(0xff2b2d2f),
      ),
      const Text(
        'Trip Calendar',
        style: kHeadingStyle,
      ),
      Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: SingleChildScrollView(
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
                      color: selectedDepatureTime == time
                          ? Theme.of(context).primaryColor
                          : const Color(0xff2d2d2d),
                      onPressed: () {
                        setState(() {
                          selectedDepatureTime = time;
                          widget.onCompleted();
                        });
                      }),
                )
            ],
          ),
        ),
      )
    ]);
  }

  _buildTimeInfo(String title, String info) {
    return RichText(
        text: TextSpan(
            text: title,
            style: const TextStyle(color: kNoteTextColorDarker),
            children: [
          TextSpan(
              text: info.toUpperCase(),
              style: TextStyle(
                color: Colors.white,
              )),
        ]));
  }

  _buildLocationSearch() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            '$kIconsPath/progress.png',
            width: 200,
          ),
          SizedBox(height: 25),
          Text(
            'Finding your location',
            style: kHeadingStyle.copyWith(fontSize: 30),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 2 / 4,
            child: Text(
              'One moment while we get your location',
              textAlign: TextAlign.center,
              style: TextStyle(color: kNoteTextColorDarker, fontSize: 20),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLocation(Axis axis) {
    int flex = axis == Axis.horizontal ? 1 : 0;
    return Flex(
      direction: axis,
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: flex,
          child: LocationInfoItem(
              location: _currentLocation,
              icon: Column(
                children: [
                  Image.asset('$kIconsPath/location_from_circle.png'),
                  Image.asset('$kIconsPath/location_from_line.png'),
                ],
              )),
        ),
        const SizedBox(
          height: 12,
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
        _currentLocation = Location(
            title: 'Lagos',
            place: 'LOS',
            country: 'Nigeria',
            imageUrl: '$kImagesPath/simone-hutsch-699861-unsplash.jpg',
            price: 500,
            description: 'My place');
        widget.onSearchCompleted();
      });
    });
  }
}
