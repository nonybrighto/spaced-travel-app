import 'package:flutter/material.dart';
import 'package:spaced_trip_scheduler/constants.dart';
import 'package:spaced_trip_scheduler/models/user.dart';
import 'package:spaced_trip_scheduler/pages/location_page.dart';
import 'package:spaced_trip_scheduler/widgets/base_view.dart';
import 'package:spaced_trip_scheduler/widgets/location_card.dart';
import 'package:spaced_trip_scheduler/widgets/user_avatar.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = User.getCurrentUser();
    const spacer = SizedBox(
      height: 10,
    );
    const doubleSpacer = SizedBox(
      height: 20,
    );
    return BaseView(
      title: 'Profile',
      subTitle: 'Info about you',
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 40),
              _buildImageHeader(context),
              doubleSpacer,
              Text(
                user.fullName,
                textAlign: TextAlign.center,
                style: kHeadingStyle.copyWith(
                  fontSize: 36,
                ),
              ),
              spacer,
              Text(
                user.description,
                style: const TextStyle(color: kNoteTextColorDarker),
              ),
              spacer,
              _buildContactsDisplay(context),
              doubleSpacer,
              _buildVisitedLocations(context),
              doubleSpacer,
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: _buildCounterInfoDisplay(),
              ),
              spacer,
              //account for bottom navbar height
              const SizedBox(
                height: 55,
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildImageHeader(BuildContext context) {
    return Stack(
      children: [
        UserAvatar(
          radius: 90,
          user: User.getCurrentUser(),
        ),
        const Positioned(
          bottom: 10,
          right: 10,
          child: CircleAvatar(
            radius: 15,
            backgroundColor: Colors.green,
            child: Icon(
              Icons.check,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  _buildContactsDisplay(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _contactButton(Colors.blue, Icons.facebook, null),
        _contactButton(Colors.green, Icons.email, null),
        _contactButton(Theme.of(context).primaryColor, Icons.phone, null),
      ],
    );
  }

  _buildVisitedLocations(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children: User.getCurrentUser()
              .visitedLocations!
              .map((location) => Container(
                    width: 180,
                    height: 180,
                    margin: const EdgeInsets.only(right: 20),
                    child: LocationCard(
                      location: location,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LocationPage(
                                  location: location,
                                )));
                      },
                    ),
                  ))
              .toList()),
    );
  }

  _buildCounterInfoDisplay() {
    const dividerLine = Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: VerticalDivider(
        color: kNoteTextColor,
        thickness: 1,
      ),
    );
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: kGreyBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _counterItem('Trips', 10),
              dividerLine,
              _counterItem('Likes', 190),
              dividerLine,
              _counterItem('Photos', 250),
            ],
          ),
        ),
      ),
    );
  }

  _contactButton(Color color, IconData icon, VoidCallback? onTap) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: CircleAvatar(
          backgroundColor: color,
          child: Icon(icon),
        ),
      ),
      onTap: onTap,
    );
  }

  _counterItem(String title, int count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title.toUpperCase(),
          style: const TextStyle(
            color: kNoteTextColorDarker,
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          count.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ],
    );
  }
}
