
import 'package:translator/translator.dart';

class TranslateDataProvider {

  Future<String> translate(String text) async{
    final GoogleTranslator translator  = GoogleTranslator();
    var translatedText =  await translator.translate(text, to: 'ru');
  return translatedText.text;
  }
}