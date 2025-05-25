import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:nina_tito_magic_book/data/models/PlayerStateEnum.dart';
import 'package:nina_tito_magic_book/game/MagicBook.dart';
import 'package:nina_tito_magic_book/game/components/GroundComponent.dart';
import 'package:nina_tito_magic_book/game/components/WallComponent.dart';

class PlayerComponent extends SpriteAnimationGroupComponent<PlayerState> with HasGameReference<MagicBook>, CollisionCallbacks {
  final String character;
  final JoystickComponent joystick;

  final Vector2 fromAbove = Vector2(0, -1);
  bool isOnGround = false;
  bool _jumpRequested = false;
  bool _movementEnabled = true;

  static const double _speed = 200.0;
  static const double _desiredHeight = 256.0;
  static const double _deadZone = 0.1;
  static const double _movementSmoothness = 0.2;
  static const double _gravity = 500.0;
  static const double _jumpForce = 300.0;

  final Vector2 _velocity = Vector2.zero();

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

    current = PlayerState.idle;

    add(RectangleHitbox(size: size));
  }

  @override
  void update(double dt) {
    super.update(dt);
    _handleHorizontalMovement(dt);
    _handleVerticalMovement(dt);
    _applyMovement(dt);
    _updatePlayerState();
  }

  void _handleHorizontalMovement(double dt) {
    if (!_movementEnabled) {
      _velocity.x = lerpDouble(_velocity.x, 0.0, _movementSmoothness * 2)!;
      return;
    }

    final rawInput = joystick.relativeDelta;
    final dx = rawInput.x.abs() < _deadZone ? 0.0 : rawInput.x;

    final targetVelocityX = dx * _speed;
    _velocity.x = lerpDouble(_velocity.x, targetVelocityX, _movementSmoothness)!;

    if (dx != 0) {
      scale.x = dx < 0 ? -1 : 1;
    }
  }

  void _handleVerticalMovement(double dt) {
    if (!isOnGround) {
      _velocity.y += _gravity * dt;
    } else {
      _velocity.y = 0;
    }

    if (isOnGround && _jumpRequested && _movementEnabled) {
      _jump();
      _jumpRequested = false;
    } else if (!_movementEnabled) {
      _jumpRequested = false;
    }
  }

  void _jump() {
    isOnGround = false;
    _velocity.y = -_jumpForce;
    current = PlayerState.jumping;
  }

  void requestJump() {
    if (isOnGround && _movementEnabled) {
      _jumpRequested = true;
    }
  }

  void enableMovement() {
    _movementEnabled = true;
  }

  void disableMovement() {
    _movementEnabled = false;
    _jumpRequested = false;
  }

  bool get isMovementEnabled => _movementEnabled;

  void _applyMovement(double dt) {
    position += _velocity * dt;
  }

  void _updatePlayerState() {
    if (!isOnGround) {
      current = PlayerState.jumping;
    } else if (_velocity.x.abs() > _speed * 0.7) {
      current = PlayerState.running;
    } else if (_velocity.x.abs() > 1) {
      current = PlayerState.walk;
    } else {
      current = PlayerState.idle;
    }
  }

  Future<Map<PlayerState, SpriteAnimation>> _loadAllAnimations() async {
    return {
      PlayerState.idle: await _loadSpriteAnimation('idle', 15),
      PlayerState.walk: await _loadSpriteAnimation('walk', 15),
      PlayerState.running: await _loadSpriteAnimation('run', 15),
      PlayerState.jumping: await _loadSpriteAnimation('jump', 15, loop: false),
    };
  }

  Future<SpriteAnimation> _loadSpriteAnimation(String state, int frames, {double stepTime = 0.05, bool loop = true}) async {
    final img = await game.images.load('main_characters/tito/$state/spritesheet.png');
    final frameSize = Vector2(
      img.width.toDouble() / frames,
      img.height.toDouble(),
    );

    return SpriteAnimation.fromFrameData(
      img,
      SpriteAnimationData.sequenced(
        amount: frames,
        stepTime: stepTime,
        textureSize: frameSize,
        loop: loop,
      ),
    );
  }

  Vector2 _calculateScaledSize(Vector2 originalSize) {
    final scaleFactor = _desiredHeight / originalSize.y;
    return originalSize * scaleFactor;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is GroundComponent && _velocity.y > 0) {
      isOnGround = true;
      position.y = other.position.y;
      _velocity.y = 0;
    }

    if (other is WallComponent) {
      final Rect playerRect = toAbsoluteRect();
      final Rect wallRect   = other.toAbsoluteRect();
      final Rect overlap    = playerRect.intersect(wallRect);

      if (overlap.width == 0 || overlap.height == 0) return;

      if (overlap.width < overlap.height) {
        if (_velocity.x > 0) {
          position.x -= overlap.width;
        } else if (_velocity.x < 0) {
          position.x += overlap.width;
        }
        _velocity.x = 0;
      } else {
        if (_velocity.y > 0) {
          position.y -= overlap.height;
          isOnGround = true;
        } else if (_velocity.y < 0) {
          position.y += overlap.height;
        }
        _velocity.y = 0;
      }
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is GroundComponent) {
      bool stillOnGround = false;
      if (!stillOnGround) {
        isOnGround = false;
      }
    }

    super.onCollisionEnd(other);
  }
}