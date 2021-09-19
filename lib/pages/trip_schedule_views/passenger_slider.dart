import 'package:flutter/material.dart';
import 'package:spaced_trip_scheduler/constants.dart';
import 'package:spaced_trip_scheduler/models/trip.dart';
import 'package:spaced_trip_scheduler/widgets/animation/faded_slide_transition.dart';
import 'package:spaced_trip_scheduler/widgets/number_picker.dart';
import 'package:spaced_trip_scheduler/widgets/sliding_panel.dart';

class PassengerSlider extends StatefulWidget {
  final Trip trip;
  final bool enabled;
  final bool showCompletedInfo;
  final Function(bool) onToggled;
  final Function(Trip) onTripChanged;
  final AnimationController introController;
  const PassengerSlider({
    Key? key,
    required this.enabled,
    required this.showCompletedInfo,
    required this.onToggled,
    required this.trip,
    required this.onTripChanged,
    required this.introController,
  }) : super(key: key);

  @override
  _PassengerSliderState createState() => _PassengerSliderState();
}

class _PassengerSliderState extends State<PassengerSlider> {
  bool _showChildSelection = false;
  late Trip _trip;
  late Animation<double> _passengarIntroAnimation;
  late Animation<double> _subTitleAnimation;
  late Animation<double> _numberPickerAnimation;
  late Animation<double> _totalAmountAnimation;

  @override
  void initState() {
    super.initState();
    _trip = widget.trip;

    _passengarIntroAnimation = CurvedAnimation(
      parent: widget.introController,
      curve: Curves.ease,
    );
    _subTitleAnimation = CurvedAnimation(
      parent: widget.introController,
      curve: const Interval(0.2, 1.0, curve: Curves.ease),
    );
    _numberPickerAnimation = CurvedAnimation(
      parent: widget.introController,
      curve: const Interval(0.4, 1.0, curve: Curves.ease),
    );
    _totalAmountAnimation = CurvedAnimation(
      parent: widget.introController,
      curve: const Interval(0.5, 1.0, curve: Curves.ease),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SlidingPanel(
      title: widget.showCompletedInfo ? _buildCompletedInfo() : 'SEATS',
      enabled: widget.enabled,
      onToggled: widget.onToggled,
      clickedOnDisabled: () {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please select a date and time to activate"),
        ));
      },
      maxHeight: MediaQuery.of(context).size.height -
          290, //subtraction is a estimated height of location time completed info based on its fixed length
      color: widget.enabled
          ? Theme.of(context).primaryColor
          : kGreyBackgroundColor,
      child: SingleChildScrollView(child: _buildPassengarSelectionInfo()),
    );
  }

  _buildPassengarSelectionInfo() {
    return Column(children: [
      FadedSlideTransition(
        animation: _passengarIntroAnimation,
        positionTween: Tween<Offset>(
          begin: const Offset(0.0, 10.0),
          end: Offset.zero,
        ),
        child: Text(
          'How many Adults?',
          style: kHeadingStyle.copyWith(fontSize: 27),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      FadedSlideTransition(
        animation: _subTitleAnimation,
        positionTween: Tween<Offset>(
          begin: const Offset(0.0, 10.0),
          end: Offset.zero,
        ),
        child: const Text(
          '12 YEARS +',
          style: TextStyle(fontSize: 14),
        ),
      ),
      FadedSlideTransition(
        animation: _numberPickerAnimation,
        positionTween: Tween<Offset>(
          begin: const Offset(0.0, 1.0),
          end: Offset.zero,
        ),
        child: SizedBox(
          height: 350,
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              NumberPicker(
                selectedValue: _trip.numberOfAdults,
                isLarge: !_showChildSelection,
                onValuePicked: (value) {
                  setState(() {
                    _trip.numberOfAdults = value;
                    widget.onTripChanged(_trip);
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                      activeColor: Colors.white,
                      checkColor: Theme.of(context).primaryColor,
                      value: _showChildSelection,
                      onChanged: (show) {
                        setState(() {
                          _showChildSelection = show!;
                          if (!show) {
                            _trip.numberOfChildren = null;
                          }
                        });
                      }),
                  const Text('Children')
                ],
              ),
              if (_showChildSelection)
                NumberPicker(
                  selectedValue: _trip.numberOfChildren,
                  isLarge: false,
                  onValuePicked: (value) {
                    setState(() {
                      _trip.numberOfChildren = value;
                      widget.onTripChanged(_trip);
                    });
                  },
                ),
            ],
          ),
        ),
      ),
      FadedSlideTransition(
        animation: _totalAmountAnimation,
        positionTween: Tween<Offset>(
          begin: const Offset(0.0, 14.0),
          end: Offset.zero,
        ),
        child: RichText(
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            text: 'Total: ',
            children: [
              TextSpan(
                text: _trip.getTripCost(),
                style: const TextStyle(
                  color: Colors.white,
                ),
              )
            ],
            style: kHeadingStyle.copyWith(
              fontSize: 25,
              color: kSliderSubColor,
            ),
          ),
        ),
      ),
      const SizedBox(
        height: kPanelHeaderHeight,
      )
    ]);
  }

  _buildCompletedInfo() {
    String adultText = _pluralize(_trip.numberOfAdults, 'ADULT', 'S');
    String childText = _trip.numberOfChildren != null
        ? ', ' + _pluralize(_trip.numberOfChildren, 'CHILD', 'REN')
        : '';
    return Text('$adultText$childText');
  }

  _pluralize(count, word, suffix) {
    return '$count $word${count != 1 ? suffix : ''}';
  }
}
