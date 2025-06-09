import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/app/home_page/bloc/cubit_home.dart';
import 'package:todo/app/home_page/bloc/state_home_.dart';
import 'package:todo/data/data_provaider/Internet_data.dart';
import 'package:todo/domain/repositores/joke_repository.dart';



class JokeHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
   return  BlocProvider(
     create: (context) => (CubitHome(repository: JokeRepository(jokeDataProvaider: JokeDataProvider()))),
     child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Joke',
          style: TextStyle(
            fontSize: 25,
            color: Color(0xff1F1D2B),
            fontWeight: FontWeight.normal,
          ),
        ),
      backgroundColor: Color(0xffEA7C69),
      ),
       body: JokeHomeViewPage(),
     ),
   );
  }
}


class JokeHomeViewPage extends StatefulWidget {
  @override
  State<JokeHomeViewPage> createState() => _JokeHomeViewPageState();
}

class _JokeHomeViewPageState extends State<JokeHomeViewPage> {
  @override
  void initState(){
      super.initState();
      BlocProvider.of<CubitHome>(context).fetchJoke();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CubitHome, JokeState>(
      builder: (BuildContext context, state) {
        print('curren state: $state');
      switch(state){
        case JokeLoading():
        return const Center(child: CircularProgressIndicator(),);
        case JokeSuccess():
          return  Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('${state.setup} \n ${state.punchline}',
                  style: TextStyle(
                  color: Colors.white,
                  fontSize: 18
                  ),
                ),
                SizedBox(height: 50,),
                ElevatedButton(
                    onPressed: (){
                      BlocProvider.of<CubitHome>(context).fetchJoke();
                    },
                    child: Text('Поменять'))
              ],
            ),
          );
        case JokeError():
          return const Center(
            child: Text('Ошибка',
              style: TextStyle(
                fontSize: 18,
                color:
                  Colors.white
              ),
            ),
          );
      }
      },
    );
  }
}














// FutureBuilder<JokeModels>(
// future: dataProvider.getFact(),
// builder: (context, snapshot){
// if(snapshot.hasData){
// return Text(snapshot.data!.setup);




// }else if (snapshot.hasError){
// return Text('${snapshot.error}');
// }
// return const CircularProgressIndicator();
// }
// )

