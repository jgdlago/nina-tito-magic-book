import 'package:flutter/material.dart';
import 'package:nina_tito_magic_book/presentation/theme/app_colors.dart';

class InfoModal extends StatelessWidget {
  final double? width;
  final double? height;
  final EdgeInsetsGeometry padding;
  final Widget child;
  final Color backgroundColor;
  final Color borderColor;

  const InfoModal({
    Key? key,
    required this.child,
    this.width,
    this.height,
    this.padding = const EdgeInsets.all(12),
    this.backgroundColor = AppColors.mysticalWhite,
    this.borderColor = AppColors.mysticalBlack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: borderColor,
          width: 4,
        ),
      ),
      child: child,
    );
  }
}
