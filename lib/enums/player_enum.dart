enum Player {
  tito,
  nina,
}

extension PlayerExtension on Player {
  String get label {
    switch (this) {
      case Player.tito:
        return 'Tito';
      case Player.nina:
        return 'Nina';
    }
  }
}
