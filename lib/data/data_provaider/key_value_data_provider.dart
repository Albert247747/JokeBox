import 'package:shared_preferences/shared_preferences.dart';


class KeyValueDataProvider  {

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


  Future<void> removeJokeFromList(String key, int jokeId) async{
    final prefs = await SharedPreferences.getInstance();
    final currentList = prefs.getStringList(key);
    currentList?.remove(jokeId);
    await prefs.setStringList(key, currentList!);
  }
}