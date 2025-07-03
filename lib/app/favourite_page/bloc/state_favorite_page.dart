import 'package:equatable/equatable.dart';
import 'package:todo/domain/model/joke_model.dart';

sealed class FavoriteJokesState extends Equatable{
  const FavoriteJokesState();

}
class FavoriteJokesLoading extends FavoriteJokesState{

  List<Object> get props => [];
}

class JokeInFavorite extends FavoriteJokesState{
  JokeInFavorite({required this.jokes});

  final List<JokeModels> jokes;

  List<Object> get props => [jokes];
}
class FavoriteJokesEmty extends FavoriteJokesState{

  final message;
  FavoriteJokesEmty({required this.message});

  List<Object> get props => [];
}
class JokeError extends FavoriteJokesState{
  JokeError(this.message);

  final String  message;

  List<Object> get props => [message];
}