import 'package:flutter/material.dart';
import 'package:spaced_trip_scheduler/models/category.dart';
import 'package:spaced_trip_scheduler/models/location.dart';
import 'package:spaced_trip_scheduler/widgets/locations_list.dart';

class LocationsListPage extends StatefulWidget {
  final Category? category;
  const LocationsListPage({Key? key, this.category}) : super(key: key);

  @override
  State<LocationsListPage> createState() => _LocationsListPageState();
}

class _LocationsListPageState extends State<LocationsListPage> {
  late List<Location> _locations;
  @override
  void initState() {
    super.initState();
    _locations = Location.getLocations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category?.name ?? 'Locations'),
      ),
      body: LocationsList(locations: _locations),
    );
  }
}
