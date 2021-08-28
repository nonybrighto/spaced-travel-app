import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Color? color;
  final Widget? child;
  final String title;
  final VoidCallback onPressed;
  final double radius;
  const AppButton({
    Key? key,
    required this.onPressed,
    this.color,
    this.child,
    this.title = 'click',
    this.radius = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        color: color ?? Theme.of(context).primaryColor,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: child ?? Text(title),
            ),
            onTap: onPressed,
          ),
        ),
      ),
    );
  }
}
