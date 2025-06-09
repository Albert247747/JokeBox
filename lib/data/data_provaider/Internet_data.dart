import 'dart:async';
import 'dart:convert';
import 'package:todo/domain/model/joke_model.dart';

import 'package:http/http.dart' as http;



class JokeDataProvider {
  Future<JokeModels> getFact() async{
    try{
      final response = await http.get(
    Uri.parse('https://official-joke-api.appspot.com/random_joke'),
      );
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return JokeModels.fromJson(jsonData);
      } else {
        throw Exception('Ошибка сервера: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Произошла ошибка: $e');
    }

  }
}



