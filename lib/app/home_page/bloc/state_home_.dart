import 'package:equatable/equatable.dart';


sealed class JokeState extends Equatable{
  const JokeState();
}
class JokeLoading extends JokeState{
  @override
  List<Object> get props => [];
}
class JokeSuccess extends JokeState{
   JokeSuccess(this.setup, this.punchline, this.id,this.isInFavourite);

  final String setup;
  final String punchline;
  final String id;
  final bool isInFavourite;

  @override
  List<Object> get props => [];

}
  class JokeError extends JokeState{
    final String message;

    const JokeError({required this.message});

    @override
    List<Object> get props => [];
}