import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:spaced_trip_scheduler/constants.dart';
import 'package:spaced_trip_scheduler/models/category.dart';
import 'package:spaced_trip_scheduler/models/location.dart';
import 'package:spaced_trip_scheduler/pages/location_page.dart';
import 'package:spaced_trip_scheduler/widgets/base_view.dart';
import 'package:spaced_trip_scheduler/widgets/category_card.dart';
import 'package:spaced_trip_scheduler/widgets/location_slider_card.dart';

class Discovery extends StatelessWidget {
  const Discovery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: 'Discover',
      subTitle: 'Trending locations today',
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSlider(context),
            Padding(
              padding: const EdgeInsets.only(
                left: kDefaultPadding,
                top: 10,
                right: kDefaultPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Feeling Adventurous?',
                    style: kHeadingStyle,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Get Inspiration from these trending categories',
                    style: TextStyle(
                      color: kNoteTextColor,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  _buildCategories(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildImageSlider(BuildContext context) {
    List<Location> sliderLocations = Location.getLocations().take(3).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: CarouselSlider(
        options: CarouselOptions(
            autoPlay: false,
            aspectRatio: 1.1,
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
            viewportFraction:
                (MediaQuery.of(context).size.width - 3 * kDefaultPadding) /
                    MediaQuery.of(context).size.width,
            disableCenter: true,
            onScrolled: (val) {
              // print(val);
            }),
        items: sliderLocations
            .map((location) => LocationSliderCard(
                  location: location,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LocationPage(
                              location: location,
                            )));
                  },
                ))
            .toList(),
      ),
    );
  }

  _buildCategories() {
    const categriesPath = '$kImagesPath/categories';
    List<Category> categories = [
      Category(name: 'Nature', imageUrl: '$categriesPath/nature.png'),
      Category(name: 'Futuristic', imageUrl: '$categriesPath/futuristic.png'),
      Category(name: 'Party', imageUrl: '$categriesPath/party.png'),
      Category(name: 'Green', imageUrl: '$categriesPath/green.png'),
    ];

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 1.8),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return CategoryCard(
          category: categories[index],
        );
      },
    );
  }
}
