import 'package:flutter/material.dart';
import 'package:nina_tito_magic_book/presentation/theme/AppColors.dart';

class InfoModal extends StatelessWidget {
  final double? width;
  final double? height;
  final EdgeInsetsGeometry padding;
  final Widget child;
  final Color backgroundColor;
  final Color borderColor;

  const InfoModal({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding = const EdgeInsets.all(12),
    this.backgroundColor = AppColors.mysticalWhite,
    this.borderColor = AppColors.mysticalBlack,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = child;
    if (height != null) {
      content = SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: width ?? 0,
            maxWidth: width ?? double.infinity,
            maxHeight: height!,
          ),
          child: child,
        ),
      );
    }

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
      child: content,
    );
  }
}

