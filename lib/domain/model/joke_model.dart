class JokeModels {

  final String setup;
  final String punchline;
  final int id;

  JokeModels({required this.punchline, required this.setup, required this.id});


  factory JokeModels.fromJson(Map<String, dynamic> json){
    return JokeModels(
        punchline: json['punchline'], setup: json['setup'], id: json['id']
    );
  }
}


