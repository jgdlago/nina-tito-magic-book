import 'dart:ui';
import 'package:flame/components.dart';
import 'package:nina_tito_magic_book/data/models/PlayerStateEnum.dart';
import 'package:nina_tito_magic_book/game/MagicBook.dart';

class PlayerComponent extends SpriteAnimationGroupComponent<PlayerState> with HasGameReference<MagicBook> {
  final String character;
  final JoystickComponent joystick;

  // Movement configuration
  static const double _speed = 200.0;
  static const double _jumpSpeed = 500.0;
  static const double _gravity = 800.0;
  static const double _desiredHeight = 256.0;
  static const double _deadZone = 0.1;
  static const double _movementSmoothness = 0.2;

  // Player state tracking
  Vector2 _velocity = Vector2.zero();
  late final double _groundY;

  // Animation objects
  late final Map<PlayerState, SpriteAnimation> _animations;

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

    _animations = await _loadAllAnimations();
    animations = _animations;

    final firstFrameSize = _animations[PlayerState.idle]!.frames.first.sprite.srcSize;
    size = _calculateScaledSize(firstFrameSize);

    _groundY = position.y;
    current = PlayerState.idle;
  }

  @override
  void update(double dt) {
    super.update(dt);

    _handleHorizontalMovement(dt);
    _handleJumping();
    _applyGravity(dt);
    _applyMovement(dt);
    _handleGroundCollision();
  }

  /// Handles left/right movement based on joystick input
  void _handleHorizontalMovement(double dt) {
    final rawInput = joystick.relativeDelta;
    final dx = rawInput.x.abs() < _deadZone ? 0.0 : rawInput.x;

    final targetVelocityX = dx * _speed;
    _velocity.x = lerpDouble(_velocity.x, targetVelocityX, _movementSmoothness)!;

    if (_velocity.x.abs() > 1) {
      current = PlayerState.walk;
      scale.x = _velocity.x < 0 ? -1 : 1; // Flip sprite based on direction
    } else {
      current = PlayerState.idle;
      _velocity.x = 0;
      scale.x = 1;
    }
  }

  /// Handles jumping when the joystick points up
  void _handleJumping() {
    if (joystick.direction == JoystickDirection.up && isOnGround) {
      _velocity.y = -_jumpSpeed;
      current = PlayerState.jumping;
    }
  }

  /// Applies gravity to vertical velocity
  void _applyGravity(double dt) {
    _velocity.y += _gravity * dt;
  }

  /// Applies velocity to position
  void _applyMovement(double dt) {
    position += _velocity * dt;
  }

  /// Handles collision with the ground
  void _handleGroundCollision() {
    if (position.y >= _groundY) {
      position.y = _groundY;
      _velocity.y = 0;
    }
  }

  /// Returns whether the player is on the ground
  bool get isOnGround => position.y >= _groundY;

  /// Loads all player animations from sprite sheets
  Future<Map<PlayerState, SpriteAnimation>> _loadAllAnimations() async {
    return {
      PlayerState.idle: await _loadSpriteAnimation('idle', 15),
      PlayerState.walk: await _loadSpriteAnimation('walk', 15),
      PlayerState.running: await _loadSpriteAnimation('run', 12),
      PlayerState.jumping: await _loadSpriteAnimation('jump', 1),
    };
  }

  /// Loads a single animation from a sprite sheet
  Future<SpriteAnimation> _loadSpriteAnimation(String state, int frames) async {
    final img = await game.images.load('main_characters/tito/$state/spritesheet.png');
    final frameSize = Vector2(
      img.width.toDouble() / frames,
      img.height.toDouble(),
    );

    return SpriteAnimation.fromFrameData(
      img,
      SpriteAnimationData.sequenced(
        amount: frames,
        stepTime: 0.05,
        textureSize: frameSize,
        loop: true,
      ),
    );
  }

  /// Calculates the scaled size based on desired height
  Vector2 _calculateScaledSize(Vector2 originalSize) {
    final scaleFactor = _desiredHeight / originalSize.y;
    return originalSize * scaleFactor;
  }
}