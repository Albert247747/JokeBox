import 'dart:convert';

import 'package:todo/data/data_provaider/joke_data_provider.dart';
import 'package:todo/data/data_provaider/translate_data_provider.dart';
import 'package:todo/domain/model/joke_model.dart';
import 'package:translator/translator.dart';


class JokeRepository {
  final JokeDataProvider _dataProvaider;
  final TranslateDataProvider _translatedprovider;

  JokeRepository(
      {
        required JokeDataProvider jokeDataProvaider,
        required TranslateDataProvider translatedprovider})
        : _dataProvaider = jokeDataProvaider,
        _translatedprovider = translatedprovider;

  Future<JokeModels> getJokeTranslate() async {
    var joke = await _dataProvaider.getJoke();
    var jokeSetup = await _translatedprovider.translate(joke.setup);
    var jokePunchline = await _translatedprovider.translate(joke.punchline);
    return JokeModels(setup: jokeSetup, punchline: jokePunchline);
  }
}


