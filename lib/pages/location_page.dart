import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:spaced_trip_scheduler/models/location.dart';
import 'package:spaced_trip_scheduler/pages/trip_schedule_page.dart';

import '../constants.dart';

class LocationPage extends StatelessWidget {
  final Location location;
  const LocationPage({
    Key? key,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey _key = GlobalKey();
    return Stack(
      children: [
        Positioned.fill(
          child: Hero(
            tag: 'location_image' + location.title,
            child: Image.asset(
              location.imageUrl,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
            child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              kBackgroundColor.withOpacity(0.5),
              kBackgroundColor.withOpacity(0.8),
            ],
            stops: const [0.0, 0.5],
          )),
        )),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              location.place.toUpperCase(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
            ],
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 600),
                  childAnimationBuilder: (widget) => SlideAnimation(
                    verticalOffset: 190.0,
                    child: FadeInAnimation(
                      duration: const Duration(milliseconds: 600),
                      child: widget,
                    ),
                  ),
                  children: [
                    Text(
                      location.title,
                      style: kHeadingStyle.copyWith(fontSize: 42),
                    ),
                    _buildWeatherDisplay(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding + 5,
                      ),
                      child: Text(
                        '${location.description} Santorini is the largest city in the New '
                        'Osogbo structure. It has a substantial '
                        'atmosphere and is the most Earth-like '
                        'satellite in the Solar System.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 21, height: 1.5),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildSecondaryInfo('colored_vr_icon', 'VR TOUR'),
                        SizedBox(
                            height: 36,
                            child: VerticalDivider(
                                thickness: 2,
                                color: Colors.white.withOpacity(0.5),
                                width: 55)),
                        _buildSecondaryInfo('gallery', 'GALLERY')
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                        vertical: 30,
                      ),
                      child: _buildButton(context, _key),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButton(BuildContext context, GlobalKey key) {
    return ClipRRect(
      key: key,
      borderRadius: BorderRadius.circular(kTripScheduleButtonRadius),
      child: Container(
        color: kPrimaryColor,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 30,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    '$kIconsPath/rocket.png',
                    fit: BoxFit.cover,
                    height: 28,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text('SCHEDULE TRIP')
                ],
              ),
            ),
            onTap: () {
              final RenderBox box =
                  key.currentContext!.findRenderObject() as RenderBox;
              final Rect sourceRect = box.localToGlobal(Offset.zero) & box.size;
              Navigator.of(context).push<void>(PageRouteBuilder<void>(
                pageBuilder: (BuildContext context, _, __) => TripSchedulePage(
                    location: location, buttonRect: sourceRect),
                transitionDuration: const Duration(milliseconds: 10),
              ));
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryInfo(String icon, String title) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('$kIconsPath/$icon.png'),
        const SizedBox(
          width: 10,
        ),
        Text(title),
      ],
    );
  }

  _buildWeatherDisplay() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white10,
        ),
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('$kIconsPath/weather.png'),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'WEATHER NOW',
                  style: TextStyle(
                    fontSize: 15,
                    color: kNoteTextColor,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  '32°C - Light Rain',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
