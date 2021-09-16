import 'package:spaced_trip_scheduler/constants.dart';
import 'package:spaced_trip_scheduler/models/location.dart';

class User {
  String firstName;
  String lastName;
  String imageUrl;
  String description;
  List<Location>? visitedLocations;

  String get fullName => '$firstName $lastName';
  User(
      {required this.firstName,
      required this.lastName,
      required this.imageUrl,
      required this.description,
      this.visitedLocations});

  static User getCurrentUser() {
    return User(
        firstName: 'Tamara',
        lastName: 'Brown',
        imageUrl: 'assets/images/profile_pics.png',
        description: 'A Lover of Adventure',
        visitedLocations: [
          Location(
              title: 'Santorini',
              place: 'New Osogbo',
              imageUrl: '$kImagesPath/simone-hutsch-699861-unsplash.jpg',
              price: 0.5,
              description: 'Description',
              country: 'Nigeria'),
          Location(
              title: 'Marrakech',
              place: 'Neptune',
              imageUrl: '$kImagesPath/kenny-luo-516116-unsplash.jpg',
              price: 2.8,
              description: 'Description',
              country: 'Nigeria'),
          Location(
              title: 'Marrakech',
              place: 'Neptune',
              imageUrl: '$kImagesPath/kenny-luo-516116-unsplash.jpg',
              price: 2.8,
              description: 'Description',
              country: 'Nigeria'),
        ]);
  }
}
