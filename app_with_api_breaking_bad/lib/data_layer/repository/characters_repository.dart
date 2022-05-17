import 'package:app_with_api/data_layer/models/characters.dart';
import 'package:app_with_api/data_layer/web_services_api/characters_api.dart';

class CharactersRepository {
  final CharactersWebServices charactersWebServices;

  CharactersRepository(this.charactersWebServices);

  Future<List<Character>> getAllCharacters() async {
    final characters = await charactersWebServices.getAllCharacters();
    return characters
        .map((character) => Character.fromJosn(character))
        .toList();
  }
}
