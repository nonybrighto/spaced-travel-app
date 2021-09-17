import 'package:spaced_trip_scheduler/constants.dart';

class Location {
  String title;
  String place;
  String country;
  String imageUrl;
  double price;
  String description;

  Location({
    required this.title,
    required this.place,
    required this.country,
    required this.imageUrl,
    required this.price,
    required this.description,
  });

  String getFormattedPrice() {
    return '$price BTC';
  }

  static List<Location> getLocations() {
    return [
      Location(
          title: 'Ophiuch',
          place: 'Kaduna',
          imageUrl: '$kImagesPath/roberto-nickson-g-549146-unsplash.jpg',
          price: 0.4,
          description: 'Description',
          country: 'Nigeria'),
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
    ];
  }
}
