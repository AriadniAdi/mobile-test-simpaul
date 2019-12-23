import 'package:flutter/material.dart';
import 'package:marvel/src/api/repository/character.dart';
import 'package:marvel/src/pages/character/character_page_bloc.dart';
import 'package:provider/provider.dart';

class CharacterPage extends StatelessWidget {
  CharacterPage({@required this.characterId}) : assert(characterId != null);
  final int characterId;
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<CharacterPageBloc>(context);
    return Container(
      color: Colors.white,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: FloatingActionButton(
              child: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              splashColor: Colors.transparent,
              elevation: 0,
              hoverElevation: 0,
              focusElevation: 0,
              backgroundColor: Colors.black.withOpacity(0.4),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(60.0),
              child: Container(),
            ),
            iconTheme: IconThemeData(color: Colors.white),
            expandedHeight: 200.0,
            pinned: true,
            flexibleSpace: StreamBuilder<Character>(
              stream: bloc.observeCharacter(characterId),
              builder: (context, snapshot) {
                return Stack(
                  children: <Widget>[
                    snapshot.data != null
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            child: Image.network(
                              snapshot.data.image.incredible,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        color: Colors.black.withOpacity(0.4),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  child: Text(
                                    snapshot.data?.name ?? '',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.bookmark,
                                    color: snapshot.data?.bookmarked ?? false
                                        ? Colors.yellow
                                        : Colors.red,
                                  ),
                                  onPressed: () => bloc.setBookmark(characterId,
                                      to: !snapshot.data.bookmarked)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          SliverFillRemaining(
            child: SingleChildScrollView(
              child: StreamBuilder<Character>(
                stream: bloc.observeCharacter(characterId),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  String description = snapshot.data?.description;
                  description = description != null && description.isNotEmpty
                      ? description
                      : 'No description provided';
                  return Material(
                    color: Colors.transparent,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Text(description),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
