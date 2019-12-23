import 'package:flutter/material.dart';
import 'package:marvel/src/api/interactors/characters_interactor.dart';
import 'package:marvel/src/api/repository/character_repository.dart';
import 'package:marvel/src/pages/about/about_page_bloc.dart';
import 'package:provider/provider.dart';

import 'src/pages/about/about_page.dart';
import 'src/pages/character/character_page.dart';
import 'src/pages/character/character_page_bloc.dart';
import 'src/pages/characters/characters_page.dart';
import 'src/pages/characters/characters_page_bloc.dart';
import 'src/pages/home/home_page.dart';

void main() async {
  final interactor = CharactersInteractor(CharacterRepository());
  runApp(
    MaterialApp(
      initialRoute: '/home',
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == '/home') {
          return MaterialPageRoute(
            builder: (context) => HomePage(),
          );
        }
        if (settings.name == '/character') {
          final bloc = CharacterPageBloc(characterInteractor: interactor);
          return MaterialPageRoute(
            builder: (context) => Provider.value(
              value: bloc,
              child: CharacterPage(
                characterId: settings.arguments,
              ),
            ),
          );
        }
        if (settings.name == '/characters') {
          final bloc = CharactersPageBloc(interactor);
          return MaterialPageRoute(
            builder: (context) => Provider.value(
              value: bloc,
              child: CharactersPage(),
            ),
          );
        }
        if (settings.name == '/about') {
          return MaterialPageRoute(
            builder: (context) => Provider.value(
              value: AboutPageBloc(),
              child: AboutPage(),
            ),
          );
        }
        return MaterialPageRoute(
          builder: (context) => Container(),
        );
      },
    ),
  );
}
