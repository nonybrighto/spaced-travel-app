import 'package:flutter/material.dart';
import 'package:spaced_trip_scheduler/constants.dart';
import 'package:spaced_trip_scheduler/widgets/user_avatar.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = kHeadingStyle.copyWith(fontSize: 35);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const UserAvatar(
            radius: 120,
          ),
          const SizedBox(height: 65),
          Text(
            'Hi Tamara',
            style: textStyle,
          ),
          const SizedBox(height: 10),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Welcome to ',
              style: textStyle,
              children: [
                TextSpan(
                  text: '\nSpaced',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
