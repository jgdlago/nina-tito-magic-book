import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nina_tito_magic_book/data/models/GenderEnum.dart';
import 'package:nina_tito_magic_book/domain/entities/Player.dart';
import 'package:nina_tito_magic_book/domain/entities/User.dart';

class GroupConnectionService {
  static Future<bool> connectToGroup(String code, User user, Player player) async {
    final response = await http.post(
      Uri.parse('http://localhost/api/$code/player'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': user.name ?? user.displayName,
        'gender': user.gender.toApiString(),
        'age': user.age,
        'character': player.character.toString().split('.').last,
        // if (player.performanceFlag != null)
        //   'performance_flag': player.performanceFlag,
      }),
    );

    return response.statusCode == 200;
  }
}