import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:nina_tito_magic_book/game/MagicBook.dart';
import 'package:nina_tito_magic_book/game/components/puzzle/level1/WardrobePuzzleComponent.dart';

class PuzzleOverlay extends RectangleComponent with HasGameReference<MagicBook> {
  static const Color _overlayColor = Color(0x90000000);
  final WardrobePuzzleComponent puzzle;

  PuzzleOverlay({required this.puzzle}) : super(
    paint: Paint()..color = _overlayColor,
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    size = game.size;
    position = Vector2.zero();
  }

  @override
  bool onTapDown(TapDownInfo info) {
    return true;
  }

  void closePuzzle() {
    add(OpacityEffect.fadeOut(
      EffectController(duration: 0.3),
      onComplete: () {
        removeFromParent();
      },
    ));
  }
}