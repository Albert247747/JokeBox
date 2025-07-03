import 'dart:convert';

import 'package:todo/data/data_provaider/joke_data_provider.dart';
import 'package:todo/data/data_provaider/translate_data_provider.dart';
import 'package:todo/domain/model/joke_model.dart';
import 'package:todo/data/data_provaider/key_value_data_provider.dart';

const jokesKey ='favorite_jokes';
class JokeRepository {
  final JokeDataProvider _dataProvaider;
  final TranslateDataProvider _translatedprovider;
  final KeyValueDataProvider _jokeKeyValueDataProvaider;


  JokeRepository(
      {
        required JokeDataProvider jokeDataProvaider,
        required TranslateDataProvider translatedprovider,
        required KeyValueDataProvider jokeKeyValueDataProvaider,
      })
        : _dataProvaider = jokeDataProvaider,
        _translatedprovider = translatedprovider,
        _jokeKeyValueDataProvaider = jokeKeyValueDataProvaider;

  Future<JokeModels> getJokeTranslate() async {
    var joke = await _dataProvaider.getJoke();
    var jokeSetup = await _translatedprovider.translate(joke.setup);
    var jokePunchline = await _translatedprovider.translate(joke.punchline);
    var jokeId = joke.id;
    return JokeModels(setup: jokeSetup, punchline: jokePunchline, id: jokeId);
  }


  //Сохраняем данные()
  void saveJokes(List<JokeModels> jokes){
  final jokesAsStrings = jokes.map((joke) {
    return json.encode(joke.toJson());
  }).toList();

  _jokeKeyValueDataProvaider.setList(jokesKey, jokesAsStrings);
  }


//Загружаем данные()
 Future<List<JokeModels>> getJokes() async{
    final jokeAsString =( await _jokeKeyValueDataProvaider.getList(jokesKey)) ?? [];
    return jokeAsString.map((joke){
      final Map<String, dynamic> jokeJson = json.decode(joke);
      return JokeModels.fromJson(jokeJson);
    }).toList();
 }
//Проверяет id(в избранном или нет)
  Future<bool> checkIdInJokes(int id) async {
    final  jokes = await getJokes();
    return jokes.any((joke) => joke.id == id);
  }
  //Сохраняем в хранилище
  Future<void> saveJokeInStorage(JokeModels newJoke) async{
    final currentJokes = await getJokes();
    currentJokes.add(newJoke);
    saveJokes(currentJokes);
  }
  //Удаление с хранилища
  Future<void> removeJokeFromStorage(int id) async{
    final joke = await getJokes();
    final List<JokeModels> updatedJokes = joke.where((joke) => joke.id != id).toList();
    saveJokes(updatedJokes);

  }

}

//  проверить(айди)
//     шутки = гет шутки
//    есть ли айди в шутках
//    вернуть да/нет
//
//  Сохранить(Моделька)
//    получить все шутки
//    добавить модельку во все шутки
//    перезаписать все шутки


