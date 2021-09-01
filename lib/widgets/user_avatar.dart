import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final double radius;
  const UserAvatar({Key? key, this.radius = 30}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: const AssetImage('assets/images/profile_pics.png'),
    );
  }
}
