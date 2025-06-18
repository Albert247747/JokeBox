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
import 'package:todo/data/data_provaider/joke_data_provider.dart';
import 'package:todo/data/data_provaider/translate_data_provider.dart';
import 'package:todo/data/repositores/joke_repository.dart';
import 'package:todo/domain/model/joke_model.dart';




class JokeHomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return BlocProvider(
      create: (context) => (CubitHome
        (repository: JokeRepository(
          jokeDataProvaider: JokeDataProvider(),
          translatedprovider: TranslateDataProvider()
      ))
      ),
      child:  Scaffold(
        backgroundColor: Color(0xFF1F1D2B),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 140,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Daily Jokes',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.3),
                            offset: Offset(0,9)
                        )
                      ]
                  ),
                ),
                centerTitle: true,
                background: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Color(0xFFE0E0E0 ).withOpacity(0.4),
                            Color(0xFF1F1D2B),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter
                      )
                  ),
                ),
              ),
              centerTitle: true,
            ),
            SliverFillRemaining(
              child: JokeHomePageView(),
            )
          ],
        ),
      ),
    );
  }
}

class JokeHomePageView extends StatefulWidget {
  const JokeHomePageView({super.key});

  @override
  State<JokeHomePageView> createState() => _JokeHomePageViewState();
}

class _JokeHomePageViewState extends State<JokeHomePageView> {
  @override
  void initState(){
    super.initState();
    BlocProvider.of<CubitHome>(context).fetchJoke();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CubitHome, JokeState>(
        builder: (BuildContext context, state) {
          switch (state){
            case JokeLoading():
              return const Center(child: CircularProgressIndicator(color: Colors.white,),
              );
            case JokeSuccess():
              return Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                          color: Color(0xFF252836),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 10,
                              offset: Offset(0,3),
                            ),
                          ]
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${state.setup}',
                            style: TextStyle(
                                fontSize: 18,
                                height: 1.5,
                                color: Colors.white,
                                fontWeight: FontWeight.w600
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24,),
                          Container(
                            width: 100,
                            height: 2,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      Color(0xFFE0E0E0).withOpacity(0.5),
                                      Colors.transparent
                                    ]
                                )
                            ),
                          ),
                          SizedBox(height: 24,),

                          Text('${state.punchline}',
                            style: TextStyle(
                                fontSize: 16,
                                height: 1.5,
                                color: Colors.white54,
                                fontStyle: FontStyle.italic
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 40,),
                    ElevatedButton(
                        onPressed: (){
                          BlocProvider.of<CubitHome>(context).fetchJoke();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white54,
                            padding: EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 16
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                        child: Text('Следующая шутка',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white
                          ),
                        )
                    )
                  ],
                ),
              );
            case JokeError():
              return const Center(
                child: Text('Ошибка',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.red
                  ),
                ),
              );
          }
        }
    );
  }
}
