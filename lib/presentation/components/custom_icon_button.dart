import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/AppColors.dart';

enum IconType { play, more, info }

class CustomIconButton extends StatelessWidget {
  final IconType type;
  final VoidCallback onPressed;
  final Color color;
  final Color iconColor;
  final bool isDisabled;

  const CustomIconButton({
    super.key,
    required this.type,
    required this.onPressed,
    required this.color,
    this.iconColor = AppColors.mysticalWhite,
    this.isDisabled = false,
  });

  String _getIconPath() {
    switch (type) {
      case IconType.play:
        return 'assets/icons/play.svg';
      case IconType.more:
        return 'assets/icons/more.svg';
      case IconType.info:
        return 'assets/icons/info.svg';
    }
  }

  @override
  Widget build(BuildContext context) {
    String iconPath = _getIconPath();

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: SvgPicture.asset(
          iconPath,
          color: iconColor,
        ),
      ),
    );
  }
}
