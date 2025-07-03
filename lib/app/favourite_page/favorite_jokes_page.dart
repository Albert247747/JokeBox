import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/app/favourite_page/bloc/cubit_favorite_page.dart';
import 'package:todo/app/favourite_page/bloc/state_favorite_page.dart';
import 'package:todo/data/data_provaider/joke_data_provider.dart';
import 'package:todo/data/data_provaider/key_value_data_provider.dart';
import 'package:todo/data/data_provaider/translate_data_provider.dart';
import 'package:todo/data/repositores/joke_repository.dart';



class FavouriteJokePage extends StatelessWidget {
  const FavouriteJokePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w700,
            color: const Color(0xFF252836),
            shadows: [
              Shadow(
                blurRadius: 10,
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(0, 9),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => FavoriteJokesCubit(
          repository: JokeRepository(
            jokeKeyValueDataProvaider: KeyValueDataProvider(),
            jokeDataProvaider: JokeDataProvider(),
            translatedprovider: TranslateDataProvider(),
          ),
        )..loadJokeFavorite(),
        child: BlocBuilder<FavoriteJokesCubit, FavoriteJokesState>(
          builder: (context, state) {
            if(state is FavoriteJokesEmty){
              return  const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.bookmark_border, size: 100, color: Colors.white,),
                    SizedBox(height: 10,),
                    Text('Нет шуток', style:  TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w700,
                      color: Colors.white54,
                      fontSize: 18
                    ),
                    ),
                    SizedBox(height: 5,),
                    Text('Добавьте шутку в "Избранное"', style:  TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w400,
                        color: Colors.white54,
                        fontSize: 10
                    ),
                    ),
                  ],
                ),
              );
            }
            if (state is JokeInFavorite) {
              return Padding(
                padding: const EdgeInsets.all(24),
                child: ListView.builder(
                  itemCount: state.jokes.length,
                  itemBuilder: (context, index) {
                    final joke = state.jokes[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Container(
                        height: 300,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFF252836),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Spacer(),
                                IconButton(
                                    onPressed: () async {
                                      await context.read<KeyValueDataProvider>().removeList('favorite_jokes');
                                      context.read<FavoriteJokesCubit>().loadJokeFavorite();
                                    },
                                    icon: Icon(Icons.delete, color: Colors.red,)
                                )
                              ],
                            ),
                            SizedBox(height: 40,),
                            Text(
                              joke.setup ?? 'No joke setup',
                              style: const TextStyle(
                                fontFamily:'Nunito',
                                fontSize: 18,
                                height: 1.5,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            Container(
                              width: 100,
                              height: 2,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    const Color(0xFFE0E0E0).withOpacity(0.5),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              joke.punchline ?? 'No joke punchline',
                              style: const TextStyle(
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                height: 1.5,
                                color: Colors.white54,
                                fontStyle: FontStyle.italic,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
