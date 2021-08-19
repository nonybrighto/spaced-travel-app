class Location {
  String title;
  String place;
  String imageUrl;
  double price;

  Location({
    required this.title,
    required this.place,
    required this.imageUrl,
    required this.price,
  });

  String getFormattedPrice() {
    return '$price BTC';
  }
}
