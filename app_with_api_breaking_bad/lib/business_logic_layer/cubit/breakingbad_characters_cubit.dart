import 'package:app_with_api/data_layer/models/characters.dart';
import 'package:app_with_api/data_layer/repository/characters_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'breakingbad_characters_state.dart';

class BreakingbadCharactersCubit extends Cubit<BreakingbadCharactersState> {
  final CharactersRepository charactersRepository;

  List<Character> characters = [];

  BreakingbadCharactersCubit(this.charactersRepository)
      : super(BreakingbadCharactersInitial());

  List<Character> getAllCharaters() {
    charactersRepository.getAllCharacters().then((charactersValue) {
      emit(CharactersLoaded(charactersValue));
      this.characters = charactersValue;
    });

    return characters;
  }
}
