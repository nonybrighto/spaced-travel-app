import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:spaced_trip_scheduler/constants.dart';

class NumberPicker extends StatefulWidget {
  final int? selectedValue;
  final bool isLarge;
  final Function(int) onValuePicked;
  const NumberPicker({
    Key? key,
    this.selectedValue,
    this.isLarge = true,
    required this.onValuePicked,
  }) : super(key: key);

  @override
  State<NumberPicker> createState() => _NumberPickerState();
}

class _NumberPickerState extends State<NumberPicker> {
  List<int> pickerValues = List.generate(
      5, (index) => index + 1); //can be passed as arguement if different
  int _page = 0;

  @override
  void initState() {
    super.initState();
    int pageFromValue =
        pickerValues.indexWhere((value) => value == widget.selectedValue);
    if (pageFromValue != -1) {
      _page = pageFromValue;
    } else {
      //set to selected value to the first value if not present
      //error can be returned instead if value not in range but set to first if null
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        widget.onValuePicked(pickerValues[0]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = widget.isLarge ? 220 : 150;
    return TweenAnimationBuilder<double>(
        tween: Tween(begin: height, end: height),
        duration: const Duration(milliseconds: 500),
        builder: (context, value, child) {
          return CarouselSlider(
            options: CarouselOptions(
                autoPlay: false,
                height: value,
                initialPage: _page,
                enableInfiniteScroll: false,
                viewportFraction: 1 / (widget.isLarge ? 3 : 5),
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                onPageChanged: (index, changeReason) {
                  setState(() {
                    _page = index;
                    widget.onValuePicked(pickerValues[_page]);
                  });
                }),
            items: pickerValues.map(
              (number) {
                bool selected = pickerValues[_page] == number;
                return Container(
                  alignment: Alignment.center,
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 500),
                    style: TextStyle(
                      fontSize: _getFontSize(selected),
                    ),
                    child: Text(
                      number.toString(),
                      style: TextStyle(
                        color: selected ? Colors.white : kSliderSubColor,
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          );
        });
  }

  double _getFontSize(bool selected) {
    if (widget.isLarge) {
      return selected ? 200 : 120;
    } else {
      return selected ? 130 : 80;
    }
  }
}
