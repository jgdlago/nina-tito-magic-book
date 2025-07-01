import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:nina_tito_magic_book/data/models/GenderEnum.dart';
import 'package:nina_tito_magic_book/domain/entities/Player.dart';
import 'package:nina_tito_magic_book/domain/entities/User.dart';

class GroupConnectionService {
  static String get baseUrl {
    return dotenv.get('BASE_URL', fallback: 'http://localhost');
  }

  static String get appToken {
    return dotenv.get('APP_TOKEN', fallback: '');
  }

  static Future<bool> connectToGroup(String code, User user, Player player) async {
    final url = '$baseUrl/$code/player';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'X-App-Token': appToken,
        },
        body: jsonEncode({
          'name': user.name ?? user.displayName,
          'gender': user.gender.toApiString(),
          'age': user.age,
          'character': player.character.toString().split('.').last,
        }),
      );

      print('URL: $url');
      print('Status Code: ${response.statusCode}');
      print('Response: ${response.body}');

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('HTTP ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      print('Erro na conexão com $url: $e');
      rethrow;
    }
  }
}