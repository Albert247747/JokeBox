import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:todo/app/home_page/bloc/state_home_.dart';
import 'package:todo/data/repositores/joke_repository.dart';



class CubitHome extends Cubit<JokeState>{

final JokeRepository repository;

CubitHome({required this.repository})
  :super(JokeLoading());

  Future<void> fetchJoke() async {
    emit(JokeLoading());
    try {
    final data = await repository.getJokeTranslate();
    emit(JokeSuccess(data.setup, data.punchline, data.id.toString(), false));
    }on Exception catch (e, stack){
      print(stack);
      emit(const JokeError(message: 'Ошибка'));
    }
  }
  void addToFavorites(int id){
    // if(state is JokeSuccess){
    //   final currentState = state as JokeSuccess;
    //   emit(JokeSuccess(setup, punchline, id))
    }
    void removeToFavorites(int id){

    }
  }


