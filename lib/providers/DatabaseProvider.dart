import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nina_tito_magic_book/data/datasources/DatabaseHelper.dart';

final databaseHelperProvider = Provider<DatabaseHelper>((_) => DatabaseHelper());
