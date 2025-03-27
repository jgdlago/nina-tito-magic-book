import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const BackgroundContainer({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.png"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Color(0x60000000),
            BlendMode.darken,
          ),
        ),
      ),
      child: Padding(
        padding: padding ??
            EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.2,
              vertical: MediaQuery.of(context).size.height * 0.1,
            ),
        child: child,
      ),
    );
  }
}
