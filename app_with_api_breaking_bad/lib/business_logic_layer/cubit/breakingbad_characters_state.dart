part of 'breakingbad_characters_cubit.dart';

@immutable
abstract class BreakingbadCharactersState {}

class BreakingbadCharactersInitial extends BreakingbadCharactersState {}


class CharactersLoaded extends BreakingbadCharactersState {

  final List <Character> characters ;

  CharactersLoaded(this.characters);
}