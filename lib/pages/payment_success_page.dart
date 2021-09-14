import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:spaced_trip_scheduler/constants.dart';
import 'package:spaced_trip_scheduler/pages/home_page.dart';

class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const spacer = SizedBox(height: 20);
    return Stack(
      children: [
        Container(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        Positioned(
          bottom: 0,
          left: -50,
          child: Container(
            height: MediaQuery.of(context).size.height * 4 / 6,
            width: MediaQuery.of(context).size.width + 200,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    alignment: Alignment.topLeft,
                    image: AssetImage('$kImagesPath/faded_rocket.png'))),
          ),
        ),
        Positioned.fill(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('$kIconsPath/check.png'),
                    spacer,
                    Column(
                      children: AnimationConfiguration.toStaggeredList(
                          duration: const Duration(milliseconds: 600),
                          childAnimationBuilder: (widget) => SlideAnimation(
                                verticalOffset: 25.0,
                                child: FadeInAnimation(
                                  duration: const Duration(milliseconds: 600),
                                  child: widget,
                                ),
                              ),
                          children: [
                            const Text(
                              "You're all set!",
                              style: kHeadingStyle,
                            ),
                            spacer,
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: const Text(
                                "A summary has been sent to your inbox",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: kNoteTextColorDarker,
                                    fontSize: 20,
                                    height: 1.5),
                              ),
                            ),
                          ]),
                    ),
                    spacer,
                    _buildTicket(context),
                    spacer,
                    TextButton(
                      child: const Text(
                        'Done',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                            (route) => false);
                      },
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

  _buildTicket(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: ClipPath(
        clipper: TicketClipPath(),
        child: Container(
          color: Theme.of(context).primaryColor,
          constraints: const BoxConstraints(
            maxWidth: 500,
            minHeight: 400,
            maxHeight: 700,
          ),
          height: MediaQuery.of(context).size.height / 2,
          child: Column(
            children: [
              Expanded(
                  child: Container(
                color: const Color(0xff932742),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      '5 Flight tickets to Santorini',
                      style: kHeadingStyle,
                      textAlign: TextAlign.center,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              )),
              Expanded(
                  child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 600),
                      childAnimationBuilder: (widget) => SlideAnimation(
                            verticalOffset: 25.0,
                            child: FadeInAnimation(
                              duration: const Duration(milliseconds: 600),
                              child: widget,
                            ),
                          ),
                      children: [
                        Image.asset('$kIconsPath/qr.png'),
                        const SizedBox(height: 20),
                        const Text('9574N 8392'),
                      ]),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class TicketClipPath extends CustomClipper<Path> {
  var radius = 30.0;
  @override
  Path getClip(Size size) {
    double halfHeight = size.height / 2;
    Path path = Path()
      ..lineTo(0, halfHeight - radius)
      ..arcToPoint(Offset(0, halfHeight + radius),
          radius: Radius.circular(radius))
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, halfHeight + radius)
      ..arcToPoint(Offset(size.width, halfHeight - radius),
          radius: Radius.circular(radius))
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
