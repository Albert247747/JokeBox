import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/domain/model/joke_model.dart';

class KeyValueDataProvider {
  Future<void> setList(String key, List<String> value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, value);
  }

  Future<List<String>?> getList(String key) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getStringList(key) ?? [];
  }

  Future<void> removeList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  Future<void> removeJokeFromList(String key, int jokeId) async {
    final prefs = await SharedPreferences.getInstance();
    final currentList = prefs.getStringList(key) ?? [];
    final currentModel = currentList
        .map((jokeStr) => JokeModels.fromJson(json.decode(jokeStr)))
        .toList();
    final updatedJokes = currentModel
        .where((joke) => joke.id != jokeId)
        .map((joke) => json.encode(joke.toJson()))
        .toList();
    await prefs.setStringList(key, updatedJokes);
  }
}