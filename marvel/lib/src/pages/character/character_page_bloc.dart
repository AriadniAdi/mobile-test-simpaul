import 'package:marvel/src/api/interactors/characters_interactor.dart';
import 'package:marvel/src/api/repository/character.dart';
import 'package:meta/meta.dart';

class CharacterPageBloc {
  CharacterPageBloc({@required CharactersInteractorType characterInteractor})
      : assert(characterInteractor != null),
        _characterInteractor = characterInteractor;

  final CharactersInteractorType _characterInteractor;

  Stream<Character> observeCharacter(int characterId) =>
      _characterInteractor.observeCharacter(characterId);

  void setBookmark(int characterId, {@required bool to}) => to
      ? _characterInteractor.bookmark(characterId)
      : _characterInteractor.unBookmark(characterId);
}
