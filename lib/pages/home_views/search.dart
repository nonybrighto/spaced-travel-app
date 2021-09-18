import 'package:flutter/material.dart';
import 'package:spaced_trip_scheduler/constants.dart';
import 'package:spaced_trip_scheduler/models/location.dart';
import 'package:spaced_trip_scheduler/widgets/app_button.dart';
import 'package:spaced_trip_scheduler/widgets/base_view.dart';
import 'package:spaced_trip_scheduler/widgets/locations_list.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late List<Location> _locations;
  TextEditingController _searchTextController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _locations = Location.getLocations();
    _searchTextController.addListener(() {
      setState(() {
        _locations = Location.getSearchedlocation(_searchTextController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: 'Search',
      subTitle: 'Find a location to visit',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchDisplay(),
          Expanded(
              child: LocationsList(
            locations: _locations,
          ))
        ],
      ),
    );
  }

  _buildSearchDisplay() {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: 15),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _searchTextController,
            style: const TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              fillColor: kGreyBackgroundColor,
              filled: true,
              hintText: 'Search...',
              hintStyle: const TextStyle(color: kNoteTextColor),
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          )),
          const SizedBox(
            width: 10,
          ),
          AppButton(
              child: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {})
        ],
      ),
    );
  }
}
