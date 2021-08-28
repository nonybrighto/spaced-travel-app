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
}
