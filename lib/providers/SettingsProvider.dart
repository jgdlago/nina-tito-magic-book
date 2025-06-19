import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsState {
  final double musicVolume;
  final double soundEffectsVolume;
  final bool vibrationEnabled;

  SettingsState({
    required this.musicVolume,
    required this.soundEffectsVolume,
    required this.vibrationEnabled,
  });

  SettingsState.initial()
      : musicVolume = 0.7,
        soundEffectsVolume = 0.8,
        vibrationEnabled = true;
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier() : super(SettingsState.initial()) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    state = SettingsState(
      musicVolume: prefs.getDouble('musicVolume') ?? 0.7,
      soundEffectsVolume: prefs.getDouble('soundEffectsVolume') ?? 0.8,
      vibrationEnabled: prefs.getBool('vibrationEnabled') ?? true,
    );
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('musicVolume', state.musicVolume);
    await prefs.setDouble('soundEffectsVolume', state.soundEffectsVolume);
    await prefs.setBool('vibrationEnabled', state.vibrationEnabled);
  }

  void setMusicVolume(double volume) {
    state = SettingsState(
      musicVolume: volume,
      soundEffectsVolume: state.soundEffectsVolume,
      vibrationEnabled: state.vibrationEnabled,
    );
    _saveSettings();
  }

  void setSoundEffectsVolume(double volume) {
    state = SettingsState(
      musicVolume: state.musicVolume,
      soundEffectsVolume: volume,
      vibrationEnabled: state.vibrationEnabled,
    );
    _saveSettings();
  }

  void setVibrationEnabled(bool enabled) {
    state = SettingsState(
      musicVolume: state.musicVolume,
      soundEffectsVolume: state.soundEffectsVolume,
      vibrationEnabled: enabled,
    );
    _saveSettings();
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>(
      (ref) => SettingsNotifier(),
);