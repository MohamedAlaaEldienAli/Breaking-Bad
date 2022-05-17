import 'package:app_with_api/business_logic_layer/cubit/breakingbad_characters_cubit.dart';
import 'package:app_with_api/constants/strings.dart';
import 'package:app_with_api/data_layer/models/characters.dart';
import 'package:app_with_api/data_layer/repository/characters_repository.dart';
import 'package:app_with_api/data_layer/web_services_api/characters_api.dart';
import 'package:app_with_api/presentation_layer/screens/characters_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation_layer/screens/characters_screen.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late BreakingbadCharactersCubit breakingbadCharactersCubit;

  AppRouter() {
    charactersRepository = CharactersRepository(CharactersWebServices());
    breakingbadCharactersCubit =
        BreakingbadCharactersCubit(charactersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) => breakingbadCharactersCubit,
                  child: CharactersScreen(),
                ));

      case charactersDetailsScreen:
      final character = settings.arguments as Character;
        return MaterialPageRoute(builder: (_) => CharactersDetailsScreen(character: character,));

      //   break;
      // default:
    }
  }
}
