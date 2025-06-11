import 'package:todo/data/data_provaider/joke_data_provider.dart';
import 'package:todo/domain/model/joke_model.dart';

class JokeRepository {
final JokeDataProvider _dataProvaider;

JokeRepository({ required JokeDataProvider jokeDataProvaider })
  :_dataProvaider = jokeDataProvaider;

Future<JokeModels> getJoke() async{
return await _dataProvaider.getFact();
  }
}

