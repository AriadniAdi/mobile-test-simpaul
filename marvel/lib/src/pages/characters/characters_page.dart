import 'package:flutter/material.dart';
import 'package:marvel/src/api/repository/character.dart';
import 'package:marvel/src/pages/characters/characters_page_bloc.dart';
import 'package:provider/provider.dart';

class CharactersPage extends StatefulWidget {
  @override
  _CharactersPageState createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  CharactersPageBloc bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = Provider.of<CharactersPageBloc>(context);
    bloc.fetchNextCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Marvel Heroes',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<Iterable<Character>>(
              stream: bloc.observeCharacters(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Container(
                    child: Text(
                      'Sorry, there was an error :/\n${snapshot.error}',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }
                if (snapshot.data != null && snapshot.data.isEmpty) {
                  return Container(
                    child: Text('Sorry!, no heroes for you :/'),
                  );
                }
                return NotificationListener<ScrollNotification>(
                  onNotification: (scrollInfo) {
                    if (snapshot.hasData &&
                        scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent) {
                      bloc.fetchNextCharacters();
                    }
                    return false;
                  },
                  child: ListView.separated(
                    separatorBuilder: (_, __) => Container(
                      height: 1,
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      final Character character =
                          snapshot.data.elementAt(index);

                      return Container(
                        color: character.bookmarked
                            ? Colors.yellow.withOpacity(0.2)
                            : Colors.white,
                        child: ListTile(
                          title: Text(character.name),
                          leading: Container(
                            width: 48.0,
                            height: 48.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(character.image.small),
                              ),
                            ),
                          ),
                          trailing: Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.black,
                          ),
                          onTap: () => Navigator.of(context)
                              .pushNamed('/character', arguments: character.id),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          StreamBuilder(
            stream: bloc.isLoading(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData && snapshot.data) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container();
            },
          )
        ],
      ),
    );
  }
}
