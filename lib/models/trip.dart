import 'package:spaced_trip_scheduler/models/location.dart';

class Trip {
  Location? source;
  Location? destination;
  int numberOfAdults;
  int? numberOfChildren;
  DateTime? startDate;
  DateTime? endDate;
  String? depatureTime;

  Trip({
    this.source,
    this.destination,
    this.numberOfAdults = 1,
    this.numberOfChildren,
    this.startDate,
    this.endDate,
    this.depatureTime,
  });

  getTripCost() {
    return (numberOfAdults + ((numberOfChildren ?? 0) * 0.5)).toString() +
        ' BTC';
  }
}
