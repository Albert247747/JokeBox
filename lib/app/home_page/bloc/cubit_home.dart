import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:todo/app/home_page/bloc/state_home_.dart';
import 'package:todo/domain/model/joke_model.dart';
import 'package:todo/domain/repositores/joke_repository.dart';
import 'package:translator/translator.dart';


class CubitHome extends Cubit<JokeState>{

final JokeRepository repository;

CubitHome({required this.repository})
  :super(JokeLoading());

  Future<void> fetchJoke() async {
    emit(JokeLoading());
    try {
    final data = await repository.getJoke();
    emit(JokeSuccess(data.setup, data.punchline));
    }on Exception catch (e){
      emit(const JokeError(message: 'Ошибка'));
    }
  }
}