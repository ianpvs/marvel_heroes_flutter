import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:marvel_heroes/domain/entities/hero.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MarvelGetHeroesService {
  final String publicKey = dotenv.env['PUBLIC_KEY']!;
  final String privateKey = dotenv.env['PRIVATE_KEY']!;
  final String baseUrl = 'https://gateway.marvel.com:443/v1/public';

  Future<List<HeroEntity>> fetchHeroes(String query) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final hash = generateMd5(timestamp + privateKey + publicKey);

    String endpoint =
        '$baseUrl/characters?ts=$timestamp&apikey=$publicKey&hash=$hash';

    if (query.isNotEmpty) {
      endpoint += '&nameStartsWith=$query';
    }

    final response = await http.get(
      Uri.parse(endpoint),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = data['data']['results'] as List;
      return results.map((heroJson) => HeroEntity.fromJson(heroJson)).toList();
    } else {
      return [];
    }
  }

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }
}
