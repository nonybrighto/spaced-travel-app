import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final Function(DateTime?, DateTime?) onRangeChanged;
  const Calendar({
    Key? key,
    this.startDate,
    this.endDate,
    required this.onRangeChanged,
  }) : super(key: key);
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  EdgeInsets cellMargin = const EdgeInsets.all(6.0);
  double rangeHighlightScale = 1.0;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOn; // Can be toggled on/off by longpressing a date
  late DateTime _focusedDay;
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();
    _rangeStart = widget.startDate;
    _rangeEnd = widget.endDate;
    _focusedDay = _rangeStart ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    Color _rangeHighlightColor = primaryColor.withOpacity(0.4);
    final rangeDecoration = BoxDecoration(
      color: primaryColor,
      shape: BoxShape.circle,
    );

    return TableCalendar(
      //can select only dates between now and 3 years ahead
      firstDay: DateTime.now(),
      lastDay: DateTime.now().add(const Duration(days: 365 * 3)),
      daysOfWeekVisible: false,
      availableGestures: AvailableGestures.horizontalSwipe,
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      rangeStartDay: _rangeStart,
      rangeEndDay: _rangeEnd,
      rangeSelectionMode: _rangeSelectionMode,
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
            _rangeStart = null; // Important to clean those
            _rangeEnd = null;
            _rangeSelectionMode = RangeSelectionMode.toggledOff;
            widget.onRangeChanged(_selectedDay, _rangeEnd);
          });
        }
      },
      onRangeSelected: (start, end, focusedDay) {
        setState(() {
          _selectedDay = null;
          _focusedDay = focusedDay;
          _rangeStart = start;
          _rangeEnd = end;
          _rangeSelectionMode = RangeSelectionMode.toggledOn;
          widget.onRangeChanged(_rangeStart, _rangeEnd);
        });
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
      calendarStyle: CalendarStyle(
        rangeHighlightColor: _rangeHighlightColor,
        cellMargin: cellMargin,
        rangeHighlightScale: rangeHighlightScale,
        todayDecoration: BoxDecoration(
            color: primaryColor.withOpacity(0.8), shape: BoxShape.circle),
        rangeStartDecoration: rangeDecoration,
        rangeEndDecoration: rangeDecoration,
      ),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        leftChevronIcon: Icon(
          Icons.chevron_left,
          color: primaryColor,
        ),
        rightChevronIcon: Icon(
          Icons.chevron_right,
          color: primaryColor,
        ),
      ),
      calendarBuilders: CalendarBuilders(
          headerTitleBuilder: (context, dateTime) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: 120,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Text(
                  DateFormat.MMMM().format(dateTime).toUpperCase(),
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                )),
            Text(
              DateFormat.y().format(dateTime),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
          //This range highlight builder simply creates border radius
          // around the end dates for the range hightlights. If it feels
          // too much , It can be simply removed to get the square shaped highlighter
          rangeHighlightBuilder: (context, day, isWithinRange) {
        return isWithinRange
            ? LayoutBuilder(builder: (context, constraints) {
                final shorterSide = constraints.maxHeight > constraints.maxWidth
                    ? constraints.maxWidth
                    : constraints.maxHeight;

                final isRangeStart = isSameDay(day, _rangeStart);
                final isRangeEnd = isSameDay(day, _rangeEnd);
                String weekDay = DateFormat.EEEE().format(day);
                return Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: _rangeHighlightColor,
                      borderRadius: _getRangeHighlighterRadius(weekDay),
                    ),
                    margin: EdgeInsetsDirectional.only(
                      start: isRangeStart ? constraints.maxWidth * 0.5 : 0.0,
                      end: isRangeEnd ? constraints.maxWidth * 0.5 : 0.0,
                    ),
                    height: (shorterSide - cellMargin.vertical) *
                        rangeHighlightScale,
                  ),
                );
              })
            : Container();
      }),
    );
  }

  BorderRadius? _getRangeHighlighterRadius(String weekDay) {
    const radius = Radius.circular(30);
    switch (weekDay) {
      case 'Sunday':
        return const BorderRadius.only(topLeft: radius, bottomLeft: radius);
      case 'Saturday':
        return const BorderRadius.only(topRight: radius, bottomRight: radius);
    }
  }
}
