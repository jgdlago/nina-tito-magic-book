import 'dart:ui';
import 'dart:math' as math;
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/input.dart';
import 'package:flutter/animation.dart';
import 'package:nina_tito_magic_book/game/MagicBook.dart';
import 'package:nina_tito_magic_book/game/components/AudioManager.dart';
import 'package:nina_tito_magic_book/game/ui/themes/GameTextStyles.dart';
import 'package:nina_tito_magic_book/presentation/theme/AppColors.dart';

enum ImageFitMode {
  contain,
  cover,
  fill,
  scaleDown,
}

class DialogComponent extends PositionComponent with HasGameReference<MagicBook> {
  late SpriteComponent background;
  late TextBoxComponent textBox;
  late HudButtonComponent continueButton;
  SpriteComponent? imageComponent;
  final String text;
  final Function? onContinue;
  final Vector2? dialogSize;
  final Image? dialogImage;
  final double imageSpacing = 10;
  final ImageFitMode imageFitMode;
  final double? maxImageWidth;
  final double? maxImageHeight;
  final String? audioPath;
  Future? _pendingAudio;
  final Curve _animationCurve = Curves.easeOutBack;
  final double _animationDuration = 0.4;
  String? _audioKey;

  DialogComponent({
    required this.text,
    this.onContinue,
    this.dialogImage,
    this.dialogSize,
    this.imageFitMode = ImageFitMode.contain,
    this.maxImageWidth,
    this.maxImageHeight,
    this.audioPath,
  }) : super(anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    final viewport = game.camera.viewport.size;
    size = dialogSize ?? Vector2(viewport.x * 0.60, viewport.y * 0.85);

    scale = Vector2.zero();

    add(
      ScaleEffect.to(
        Vector2.all(1),
        EffectController(
          duration: _animationDuration,
          curve: _animationCurve,
        ),
      ),
    );

    // Background
    final image = await game.images.load('ui/dialog_torn_paper.png');
    background = SpriteComponent(
      sprite: Sprite(image),
      size: size,
      position: Vector2.zero(),
      anchor: Anchor.topLeft,
    );
    add(background);

    // Text
    textBox = TextBoxComponent(
      text: text,
      boxConfig: TextBoxConfig(maxWidth: size.x * 0.85),
      textRenderer: TextPaint(style: GameTextStyles.dialogBody),
      position: Vector2(size.x * 0.5, 0),
      anchor: Anchor.topCenter,
    );
    add(textBox);

    // Button
    await _addButton();

    if (dialogImage != null) {
      final imageSize = _calculateOptimalImageSize();
      imageComponent = SpriteComponent(
        sprite: Sprite(dialogImage!),
        size: imageSize,
        position: Vector2(size.x * 0.5, 0),
        anchor: Anchor.topCenter,
      );
      add(imageComponent!);
    }

    position = viewport / 2;

    if (audioPath != null && AudioManager.narratorActive) {
      _pendingAudio = Future.delayed(const Duration(seconds: 1), () async {
        if (!isRemoved) {
          _audioKey = 'dialog_$hashCode';
          AudioManager.startLongAudio(_audioKey!, audioPath!);
        }
      });
    }

    await super.onLoad();
  }

  Vector2 _calculateOptimalImageSize() {
    if (dialogImage == null) return Vector2.zero();

    final originalWidth = dialogImage!.width.toDouble();
    final originalHeight = dialogImage!.height.toDouble();

    final maxWidth = maxImageWidth ?? (size.x * 0.8);
    final maxHeight = maxImageHeight ?? (size.y * 0.4);

    Vector2 calculatedSize;

    switch (imageFitMode) {
      case ImageFitMode.contain:
        calculatedSize = _calculateContainSize(
            originalWidth, originalHeight, maxWidth, maxHeight
        );
        break;

      case ImageFitMode.cover:
        calculatedSize = _calculateCoverSize(
            originalWidth, originalHeight, maxWidth, maxHeight
        );
        break;

      case ImageFitMode.fill:
        calculatedSize = Vector2(maxWidth, maxHeight);
        break;

      case ImageFitMode.scaleDown:
        final containSize = _calculateContainSize(
            originalWidth, originalHeight, maxWidth, maxHeight
        );
        calculatedSize = Vector2(
          math.min(containSize.x, originalWidth),
          math.min(containSize.y, originalHeight),
        );
        break;
    }

    return calculatedSize;
  }

  Vector2 _calculateContainSize(double originalWidth, double originalHeight,
      double maxWidth, double maxHeight) {
    final originalAspectRatio = originalWidth / originalHeight;
    final maxAspectRatio = maxWidth / maxHeight;

    if (originalAspectRatio > maxAspectRatio) {
      return Vector2(maxWidth, maxWidth / originalAspectRatio);
    } else {
      return Vector2(maxHeight * originalAspectRatio, maxHeight);
    }
  }

  Vector2 _calculateCoverSize(double originalWidth, double originalHeight,
      double maxWidth, double maxHeight) {
    final originalAspectRatio = originalWidth / originalHeight;
    final maxAspectRatio = maxWidth / maxHeight;

    if (originalAspectRatio > maxAspectRatio) {
      return Vector2(maxHeight * originalAspectRatio, maxHeight);
    } else {
      return Vector2(maxWidth, maxWidth / originalAspectRatio);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    position = game.camera.viewport.size / 2;

    if (textBox.size.y > 0) {
      textBox.position.y = (size.y - textBox.size.y - (imageComponent != null
          ? imageComponent!.size.y + imageSpacing
          : 0) - continueButton.size.y - 16) * 0.20;

      if (imageComponent != null) {
        imageComponent!.position.y = textBox.position.y +
            textBox.size.y +
            imageSpacing;
      }

      continueButton.position.y = size.y - continueButton.size.y * 0.75;
    }
  }

  Future<void> _addButton() async {
    final buttonSprite = await game.images.load('ui/default_button.png');
    final buttonSize = Vector2(size.x * 0.3, 50);

    continueButton = HudButtonComponent(
        button: SpriteComponent(
          sprite: Sprite(buttonSprite),
          size: buttonSize,
        ),
        anchor: Anchor.center,
        position: Vector2(size.x * 0.5, size.y * 0.85),
        size: buttonSize,
        onPressed: () {
          _stopAudio();
          onContinue?.call();
          removeFromParent();
        }
    );

    continueButton.add(
      TextComponent(
        text: 'Continuar',
        position: continueButton.size / 2,
        textRenderer: TextPaint(
          style: GameTextStyles.dialogBody.copyWith(
            color: AppColors.mysticalBlack,
          ),
        ),
        anchor: Anchor.center,
        priority: 1000,
      ),
    );

    add(continueButton);
  }

  void _stopAudio() {
    _pendingAudio?.ignore();
    _pendingAudio = null;

    if (_audioKey != null) {
      AudioManager.stopLongAudio(_audioKey!);
      _audioKey = null;
    }
  }

  @override
  void onRemove() {
    _stopAudio();
    AudioManager.restoreBGMVolume();
    super.onRemove();
  }
}