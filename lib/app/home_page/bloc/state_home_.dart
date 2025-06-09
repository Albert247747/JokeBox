import 'package:equatable/equatable.dart';


sealed class JokeState extends Equatable{
  const JokeState();
}
class JokeLoading extends JokeState{
  @override
  List<Object> get props => [];
}
class JokeSuccess extends JokeState{
  const JokeSuccess(this.setup, this.punchline);

  final String setup;
  final String punchline;

  @override
  List<Object> get props => [];

}
  class JokeError extends JokeState{
    final String message;

    const JokeError({required this.message});

    @override
    List<Object> get props => [];
}