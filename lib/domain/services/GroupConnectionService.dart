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

  static Future<bool> connectToGroup(String code, User user, Player player) async {
    final url = '$baseUrl/$code/player';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'name': user.name ?? user.displayName,
          'gender': user.gender.toApiString(),
          'age': user.age,
          'character': player.character.toString().split('.').last,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        try {
          final errorData = jsonDecode(response.body);
          throw Exception('Erro ${response.statusCode}: ${errorData['message']}');
        } catch (_) {
          throw Exception('Erro ${response.statusCode}: ${response.body}');
        }
      }
    } catch (e) {
      print('Erro na conexão com $url: $e');
      rethrow;
    }
  }
}