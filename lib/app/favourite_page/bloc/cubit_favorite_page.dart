import 'package:todo/app/favourite_page/bloc/state_favorite_page.dart';
import 'package:bloc/bloc.dart';
import 'package:todo/data/repositores/joke_repository.dart';
import 'package:todo/domain/model/joke_model.dart';

class FavoriteJokesCubit extends Cubit<FavoriteJokesState>{

  final JokeRepository repository;


  FavoriteJokesCubit({required this.repository})
      :super(FavoriteJokesLoading());

  JokeModels? _currentjoke;

Future<void> loadJokeFavorite() async{
  emit(FavoriteJokesLoading());
  try{
    final jokes = await repository.getJokes();
    if(jokes.isEmpty){
      emit(FavoriteJokesEmty(message: 'Нет избранных шуток'));
    } else {
      emit(JokeInFavorite(jokes: jokes));
    }
  }on Exception catch(e, stack){
    print(stack);
    emit(JokeError('Не удалось загрузить избранное'));
  }
  
}

  Future<void> deleteFavorite() async{
    try{
      final currentState = state;
      if (_currentjoke == null || currentState is! JokeInFavorite) return;
      await repository.removeJokeFromStorage(_currentjoke!.id);
      final updateJoke = currentState.jokes.where((joke) => joke.id != _currentjoke!.id).toList();
      emit(JokeInFavorite(jokes: updateJoke));
      print('delete joke');
    }on Exception catch(e){
      emit(JokeError('Ошибка удаления шутки'));
    }
  }
}