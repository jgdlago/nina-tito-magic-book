import 'package:flutter/material.dart';
import 'package:nina_tito_magic_book/presentation/theme/app_colors.dart';

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
        return 'Confirmar';
      case ButtonType.denial:
        return 'Cancelar';
      case ButtonType.warning:
        return 'Mais';
    }
  }

  @override
  Widget build(BuildContext context) {
    final buttonText = text ?? _getDefaultText();

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
          backgroundColor: _getBackgroundColor(),
          foregroundColor: Colors.white,
          textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(buttonText),
      ),
    );
  }
}
