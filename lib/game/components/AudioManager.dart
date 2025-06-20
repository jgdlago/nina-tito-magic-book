import 'package:flame_audio/flame_audio.dart';

class AudioManager {
  static AudioPlayer? _bgmPlayer;
  static double _bgmVolume = 0.7; // Valor padrão
  static bool _bgmPaused = false;
  static final Map<String, AudioPlayer> _activeAudios = {};
  static bool _narratorActive = true;
  static bool get narratorActive => _narratorActive;

  static Future<void> playBGM(String path, {double volume = 0.7}) async {
    _bgmVolume = volume;

    if (_bgmPlayer != null) {
      _bgmPlayer!.setVolume(_bgmVolume);
      return;
    }

    _bgmPlayer = AudioPlayer()
      ..setVolume(_bgmVolume)
      ..setReleaseMode(ReleaseMode.loop);

    await _bgmPlayer!.play(AssetSource(path));
  }

  static void setMusicVolume(double volume) {
    _bgmVolume = volume;
    if (_bgmPlayer != null && _bgmPlayer!.state == PlayerState.playing) {
      _bgmPlayer!.setVolume(_bgmVolume);
    }
  }

  static void updateBGMVolume() {
    if (_bgmPlayer == null) return;

    if (_activeAudios.isNotEmpty) {
      _bgmPlayer!.setVolume(_bgmVolume * 0.25);
    } else {
      _bgmPlayer!.setVolume(_bgmVolume);
    }
  }

  static void restoreBGMVolume() {
    if (_bgmPlayer == null) return;
    _bgmPlayer!.setVolume(_bgmVolume);
  }

  static Future<void> startLongAudio(String key, String path) async {
    // Pausar temporariamente
    if (_bgmPlayer != null && _bgmPlayer!.state == PlayerState.playing) {
      await _bgmPlayer!.pause();
      _bgmPaused = true;
    }

    if (_activeAudios.containsKey(key)) {
      _activeAudios[key]?.stop();
      _activeAudios.remove(key);
    }

    final player = AudioPlayer()
      ..setReleaseMode(ReleaseMode.release);

    _activeAudios[key] = player;

    await player.play(AssetSource(path));

    player.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.completed || state == PlayerState.stopped) {
        stopLongAudio(key);
      }
    });
  }

  static void stopLongAudio(String key) {
    if (!_activeAudios.containsKey(key)) return;

    final player = _activeAudios[key]!;
    player.stop();
    player.dispose();
    _activeAudios.remove(key);

    // Restaurar BGM se estava pausado
    if (_bgmPaused && _bgmPlayer != null && _bgmPlayer!.state == PlayerState.paused) {
      _bgmPlayer!.resume();
      _bgmPaused = false;
    }
  }

  static void pauseBGM() {
    if (_bgmPlayer != null && _bgmPlayer!.state == PlayerState.playing) {
      _bgmPlayer!.pause();
    }
  }

  static void resumeBGM() {
    if (_bgmPlayer != null && _bgmPlayer!.state == PlayerState.paused) {
      _bgmPlayer!.resume();
    }
  }

  static void dispose() {
    _bgmPlayer?.stop();
    _bgmPlayer?.dispose();
    _bgmPlayer = null;

    for (final player in _activeAudios.values) {
      player.stop();
      player.dispose();
    }
    _activeAudios.clear();
  }

  static set narratorActive(bool active) {
    _narratorActive = active;
    if (!active) {
      stopAllNarrations();
    }
  }

  static void stopAllNarrations() {
    final keys = _activeAudios.keys.toList();
    for (final key in keys) {
      stopLongAudio(key);
    }
  }
}