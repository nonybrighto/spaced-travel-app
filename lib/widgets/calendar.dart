import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime rangeStartDay = DateTime.now().subtract(Duration(
      days: 2,
    ));
    DateTime rangeEndDay = DateTime.now().add(Duration(days: 7));
    EdgeInsets cellMargin = const EdgeInsets.all(6.0);
    double rangeHighlightScale = 1.0;
    final primaryColor = Theme.of(context).primaryColor;
    Color _rangeHighlightColor = primaryColor.withOpacity(0.4);

    final rangeDecoration = BoxDecoration(
      color: primaryColor,
      shape: BoxShape.circle,
    );
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TableCalendar(
                
                calendarStyle: CalendarStyle(
                  rangeHighlightColor: _rangeHighlightColor,
                  cellMargin: cellMargin,
                  rangeHighlightScale: rangeHighlightScale,
                  todayDecoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.8),
                      shape: BoxShape.circle),
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
                daysOfWeekVisible: false,
                firstDay:
                    DateTime(DateTime.now().year, DateTime.now().month, 1),
                lastDay: DateTime.utc(2030, 3, 14),
                rangeStartDay: rangeStartDay,
                rangeEndDay: rangeEndDay,
                focusedDay: DateTime.now(),
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
                          final shorterSide =
                              constraints.maxHeight > constraints.maxWidth
                                  ? constraints.maxWidth
                                  : constraints.maxHeight;

                          final isRangeStart = isSameDay(day, rangeStartDay);
                          final isRangeEnd = isSameDay(day, rangeEndDay);
                          String weekDay = DateFormat.EEEE().format(day);
                          return Center(
                            child: Container(
                              decoration: BoxDecoration(
                                color: _rangeHighlightColor,
                                borderRadius:
                                    _getRangeHighlighterRadius(weekDay),
                              ),
                              margin: EdgeInsetsDirectional.only(
                                start: isRangeStart
                                    ? constraints.maxWidth * 0.5
                                    : 0.0,
                                end: isRangeEnd
                                    ? constraints.maxWidth * 0.5
                                    : 0.0,
                              ),
                              height: (shorterSide - cellMargin.vertical) *
                                  rangeHighlightScale,
                            ),
                          );
                        })
                      : Container();
                }),
              )
            ],
          ),
        ),
      ),
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
