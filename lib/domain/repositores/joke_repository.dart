import 'package:todo/data/data_provaider/Internet_data.dart';
import 'package:todo/domain/model/joke_model.dart';

class JokeRepository {
final JokeDataProvider _dataProvaider;

JokeRepository({ required JokeDataProvider jokeDataProvaider })
  :_dataProvaider = jokeDataProvaider;

Future<JokeModels> getFacts() async{
return await _dataProvaider.getFact();
  }
}

