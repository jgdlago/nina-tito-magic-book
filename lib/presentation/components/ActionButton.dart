import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nina_tito_magic_book/presentation/theme/AppColors.dart';

enum ButtonType { confirmation, denial, warning }

class ActionButton extends StatelessWidget {
  final ButtonType type;
  final String? text;
  final VoidCallback onPressed;
  final bool isDisabled;

  const ActionButton({
    super.key,
    required this.type,
    required this.onPressed,
    this.text,
    this.isDisabled = false,
  });

  Color _getBackgroundColor() {
    if (isDisabled) return Colors.grey;
    switch (type) {
      case ButtonType.confirmation:
        return AppColors.confirmationGreen;
      case ButtonType.denial:
        return AppColors.denialRed;
      case ButtonType.warning:
        return AppColors.warningAmber;
    }
  }

  String _getDefaultText() {
    switch (type) {
      case ButtonType.confirmation:
        return 'Continuar';
      case ButtonType.denial:
        return 'Voltar';
      case ButtonType.warning:
        return 'Mais';
    }
  }

  Widget? _getIcon() {
    switch (type) {
      case ButtonType.confirmation:
        return SvgPicture.asset(
          'assets/icons/arrow_right.svg',
          width: 16,
          height: 16,
          color: Colors.white,
        );
      case ButtonType.denial:
        return SvgPicture.asset(
          'assets/icons/arrow_left.svg',
          width: 16,
          height: 16,
          color: Colors.white,
        );
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final buttonText = text ?? _getDefaultText();
    final icon = _getIcon();

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
          backgroundColor: _getBackgroundColor(),
          foregroundColor: Colors.white,
          textStyle: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: type == ButtonType.denial
              ? [
            if (icon != null) icon,
            const SizedBox(width: 8),
            Text(buttonText),
          ]
              : type == ButtonType.confirmation
              ? [
            Text(buttonText),
            const SizedBox(width: 8),
            if (icon != null) icon,
          ]
              : [
            Text(buttonText),
          ],
        ),
      ),
    );
  }
}
