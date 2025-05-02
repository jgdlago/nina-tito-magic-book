import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:nina_tito_magic_book/data/models/PlayerStateEnum.dart';
import 'package:nina_tito_magic_book/game/MagicBook.dart';

class PlayerComponent extends SpriteAnimationGroupComponent<PlayerState>
    with HasGameReference<MagicBook> {
  final String character;
  final JoystickComponent joystick;

  // parâmetros configuráveis px/s
  final double speed = 200;
  final double jumpSpeed = 500;
  final double gravity = 800;
  final double desiredHeight = 256;

  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation walkAnimation;
  late final SpriteAnimation runAnimation;
  late final SpriteAnimation jumpAnimation;

  Vector2 velocity = Vector2.zero();
  late final double groundY;

  PlayerComponent({
    required this.character,
    required Vector2 position,
    required this.joystick,
  }) : super(
    position: position,
    anchor: Anchor.bottomCenter,
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    await _loadAllAnimations();

    size = _setSize(idleAnimation.frames.first.sprite.srcSize);

    groundY = position.y;

    current = PlayerState.idle;
  }

  @override
  void update(double dt) {
    super.update(dt);

    final raw = joystick.relativeDelta;
    const deadZone = 0.1;
    final dx = raw.x.abs() < deadZone ? 0.0 : raw.x;

    final targetVx = dx * speed;
    velocity.x = lerpDouble(velocity.x, targetVx, 0.2)!;

    if (velocity.x.abs() > 1) {
      current = PlayerState.walk;
      scale.x = velocity.x < 0 ? -1 : 1;
    } else {
      current = PlayerState.idle;
      velocity.x = 0;
      scale.x = 1;
    }


    if (joystick.direction == JoystickDirection.up && isOnGround) {
      velocity.y = -jumpSpeed;
      current = PlayerState.jumping;
    }

    // gravidade
    velocity.y += gravity * dt;

    // aplica movimento
    position += velocity * dt;

    // colisão chão
    if (position.y >= groundY) {
      position.y = groundY;
      velocity.y = 0;
    }
  }

  bool get isOnGround => position.y >= groundY;

  Future<void> _loadAllAnimations() async {
    idleAnimation = await _loadAnim('idle', 15);
    walkAnimation = await _loadAnim('walk', 15);
    runAnimation  = await _loadAnim('run', 12);
    jumpAnimation = await _loadAnim('jump', 1);

    animations = {
      PlayerState.idle:    idleAnimation,
      PlayerState.walk:    walkAnimation,
      PlayerState.running: runAnimation,
      PlayerState.jumping: jumpAnimation,
    };
  }

  Future<SpriteAnimation> _loadAnim(String state, int frames) async {
    final img = await game.images.load('main_characters/tito/$state/spritesheet.png');
    final frameSize = Vector2(
      img.width.toDouble()  / frames,
      img.height.toDouble(),
    );
    return SpriteAnimation.fromFrameData(
      img,
      SpriteAnimationData.sequenced(
        amount:      frames,
        stepTime:    0.05,
        textureSize: frameSize,
        loop:        true,
      ),
    );
  }

  Vector2 _setSize(Vector2 firstFrame) {
    final scaleFactor = desiredHeight / firstFrame.y;
    return firstFrame * scaleFactor;
  }
}
