import 'package:flutter/material.dart';
import 'package:spaced_trip_scheduler/constants.dart';

class ButtonFillTransition extends StatelessWidget {
  final Rect buttonRect;
  final Widget child;
  final AnimationController animation;

  const ButtonFillTransition(
      {Key? key,
      required this.buttonRect,
      required this.child,
      required this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBarHeight = AppBar().preferredSize.height;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final Animation<double> positionAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.fastOutSlowIn,
        );

        //subtract appbar's Height from globally positioned buttonRect to get a closer position. StatusbarHeight not included
        final Animation<RelativeRect> itemPosition = RelativeRectTween(
          begin: RelativeRect.fromLTRB(
            buttonRect.left,
            buttonRect.top - appBarHeight,
            constraints.biggest.width - buttonRect.right,
            constraints.biggest.height - buttonRect.bottom + appBarHeight,
          ),
          end: RelativeRect.fill,
        ).animate(positionAnimation);

        final BorderRadiusTween borderTween = BorderRadiusTween(
          begin: BorderRadius.circular(kTripScheduleButtonRadius),
          end: BorderRadius.circular(kPanelRadius),
        );

        final Animation<double> backgroundFade = CurvedAnimation(
          parent: animation,
          curve: const Interval(0, 1, curve: Curves.ease),
        );

        final Animation<double> scaleAnimation = CurvedAnimation(
          parent: animation,
          curve: const Interval(0.0, 0.9, curve: Curves.fastOutSlowIn),
        );

        final ColorTween colorTween = ColorTween(
            begin: Theme.of(context).primaryColor, end: kBackgroundColor);

        return Stack(
          children: [
            PositionedTransition(
              rect: itemPosition,
              child: AnimatedBuilder(
                animation: positionAnimation,
                child: child,
                builder: (BuildContext context, Widget? child) {
                  return ClipRRect(
                    borderRadius: borderTween.evaluate(positionAnimation),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: colorTween.evaluate(animation),
                          child: FadeTransition(
                            opacity: backgroundFade,
                            child: ScaleTransition(
                                alignment: Alignment.topCenter,
                                scale: scaleAnimation,
                                child: child),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
