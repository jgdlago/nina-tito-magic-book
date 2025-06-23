import 'package:nina_tito_magic_book/data/models/GenderEnum.dart';

const String createPlayersTable = '''
  CREATE TABLE players(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    character TEXT NOT NULL,
    equipped_skin TEXT NOT NULL
  )
''';

String genderMasc = GenderEnum.male.label;
String genderFem = GenderEnum.female.label;

final String createUsersTable = '''
  CREATE TABLE users(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    age INTEGER NOT NULL,
    gender TEXT CHECK(gender IN ('$genderMasc', '$genderFem')) NOT NULL,
    player_id INTEGER UNIQUE NULL,
    terms_accepted_at DATETIME NULL,
    FOREIGN KEY (player_id) REFERENCES players(id) ON DELETE SET NULL
  )
''';

const String createLevelsTable = '''
  CREATE TABLE levels(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    message TEXT NOT NULL,
    level_order INTEGER NOT NULL,
    finished_at DATETIME DEFAULT NULL
  )
''';

const String createUserProgressTable = '''
  CREATE TABLE user_progress(
    user_id INTEGER NOT NULL,
    level_id INTEGER NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, level_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (level_id) REFERENCES levels(id) ON DELETE CASCADE
  )
''';

const String createItemsTable = '''
  CREATE TABLE items(
    id            INTEGER PRIMARY KEY AUTOINCREMENT,
    name          TEXT    NOT NULL,
    description   TEXT,
    collected_at  DATETIME DEFAULT CURRENT_TIMESTAMP
  )
''';