import 'package:marvel/src/api/interactors/characters_interactor.dart';
import 'package:marvel/src/api/repository/character.dart';
import 'package:rxdart/rxdart.dart';
import 'package:collection/collection.dart';

class CharactersPageBloc {
  CharactersPageBloc(this.interactor) {
    _isLoadingSubject
        .where((isLoading) => isLoading)
        .debounceTime(Duration(milliseconds: 100))
        .listen((_) {
      interactor
          .loadCharacters()
          .whenComplete(() => _isLoadingSubject.add(false));
    });
  }

  final CharactersInteractorType interactor;

  final BehaviorSubject<bool> _isLoadingSubject = BehaviorSubject();

  Stream<Iterable<Character>> observeCharacters() =>
      interactor.observeCharacters().map(
        (characters) {
          final charactersGrouped = groupBy(
            characters,
            (character) => character.bookmarked,
          );
          return [
                ...charactersGrouped[true] ?? [],
                ...charactersGrouped[false]
              ] ??
              [];
        },
      );

  Stream<bool> isLoading() => _isLoadingSubject;

  void fetchNextCharacters() => _isLoadingSubject.add(true);
}
