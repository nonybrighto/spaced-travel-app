import 'package:flutter/material.dart';
import 'package:spaced_trip_scheduler/models/user.dart';

class UserAvatar extends StatelessWidget {
  final double radius;
  final User user;
  const UserAvatar({Key? key, this.radius = 30, required this.user,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: AssetImage(user.imageUrl),
    );
  }
}
