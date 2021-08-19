import 'package:flutter/material.dart';
import 'package:spaced_trip_scheduler/widgets/base_view.dart';

class Discovery extends StatelessWidget {
  const Discovery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: 'Discover',
      subTitle: 'Trending locations today',
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Hello ss ' * 90,
              style: TextStyle(fontSize: 90),
            ),
          ],
        ),
      ),
    );
  }

  //  _buildImageSlider() {
  //   List<String> imageList = [
  //     'theme_one.png',
  //     'theme_two.png',
  //     'theme_three.png'
  //   ];

  //   return CarouselSlider(
  //               items: imageList
  //                   .map((image) => _buildImageDisplay(image))
  //                   .toList(),
  //               options: CarouselOptions(
  //                   initialPage: _getInitialPage(appProvider.themeType),
  //                   autoPlay: false,
  //                   enlargeCenterPage: true,
  //                   height: MediaQuery.of(context).size.height * 1 / 2,
  //                   // aspectRatio: 0.9,
  //                   viewportFraction: 0.6,
  //                   onPageChanged: (index, reason) {
  //                     switch (index) {
  //                       case 0:
  //                         appProvider.changeThemeType(ThemeType.one);
  //                         break;
  //                       case 1:
  //                         appProvider.changeThemeType(ThemeType.two);
  //                         break;
  //                       case 2:
  //                         appProvider.changeThemeType(ThemeType.three);
  //                         break;
  //                       default:
  //                         appProvider.changeThemeType(ThemeType.one);
  //                     }

  //                     setState(() {
  //                       _currentIndex = index;
  //                     });
  //                   });
  // }
}
