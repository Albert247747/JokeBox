class JokeModels {


  final String setup;
  final String punchline;


  JokeModels({required this.punchline, required this.setup});


  factory JokeModels.fromJson(Map<String, dynamic> json){
    return JokeModels(
        punchline: json['punchline'], setup: json['setup']
    );
  }
}


