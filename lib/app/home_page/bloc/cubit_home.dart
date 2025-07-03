import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:todo/app/home_page/bloc/state_home_.dart';
import 'package:todo/data/repositores/joke_repository.dart';
import 'package:todo/domain/model/joke_model.dart';



class CubitHome extends Cubit<JokeState>{

final JokeRepository repository;

CubitHome({required this.repository})
  :super(JokeLoading());

  JokeModels? _currentjoke;

  Future<void> fetchJoke() async {
    emit(JokeLoading());
    try {
    final data = await repository.getJokeTranslate();
    _currentjoke = data;
    final isFavourite = await repository.checkIdInJokes(data.id);
    emit(JokeSuccess(data.setup, data.punchline, data.id.toString(), isFavourite));
    }on Exception catch (e, stack){
      print(stack);
      emit(const JokeError(message: 'Ошибка'));
    }
  }
  Future<void> addToFavorite() async{ //emit с переводом состония в true, репозиторий обновить
    try{
      final currentState = state;
      if(_currentjoke == null || currentState is! JokeSuccess)return;

      await repository.saveJokeInStorage(_currentjoke!);
      emit(JokeSuccess(_currentjoke!.setup, _currentjoke!.punchline, _currentjoke!.id.toString(), true));
      print('Adding to favorite');
    }on Exception catch (e){
      emit(JokeError(message: 'Ошибка добавления в избранное'));
    }

  }
    Future<void> removeToFavorite() async{ // emit с переводом с true в false, репозиторий обновить
    try{
      final currentState = state;
      if (_currentjoke == null || currentState is! JokeSuccess) return;
      await repository.removeJokeFromStorage(_currentjoke!.id);
      emit(JokeSuccess(currentState.setup, currentState.punchline, currentState.id, false));
      print('delete joke');
    }on Exception catch(e){
      emit(JokeError(message: 'Ошибка удаления шутки'));
    }
    }
}


