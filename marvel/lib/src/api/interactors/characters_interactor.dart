import 'package:marvel/src/api/repository/character.dart';
import 'package:marvel/src/api/repository/character_repository.dart';
import 'package:rxdart/rxdart.dart';

abstract class CharactersInteractorType {
  Stream<Iterable<Character>> observeCharacters();
  Stream<Character> observeCharacter(int id);

  void bookmark(int characterId);
  void unBookmark(int characterId);
  Future<void> loadCharacters();
}

class CharactersInteractor extends CharactersInteractorType {
  CharactersInteractor(this.repository);

  final BehaviorSubject<Iterable<Character>> _characterSubject =
      BehaviorSubject();

  final CharacterRepository repository;

  @override
  Stream<Iterable<Character>> observeCharacters() => _characterSubject;

  @override
  Stream<Character> observeCharacter(int id) =>
      _characterSubject.flatMap((characters) => Stream.fromIterable(
          characters.where((character) => character.id == id)));

  @override
  void bookmark(int characterId) {
    final characters = (_characterSubject.value ?? []).map((character) =>
        character.id == characterId
            ? character.copyWith(bookmarked: true)
            : character);
    _characterSubject.add(characters);
  }

  @override
  void unBookmark(int characterId) {
    final characters = (_characterSubject.value ?? []).map((character) =>
        character.id == characterId
            ? character.copyWith(bookmarked: false)
            : character);
    _characterSubject.add(characters);
  }

  @override
  Future<void> loadCharacters() => repository
      .fetchCharacters(_characterSubject.value?.length ?? 0)
      .then((characters) => _characterSubject
          .add([..._characterSubject.value ?? [], ...characters]));
}
