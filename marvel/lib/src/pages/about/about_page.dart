import 'package:flutter/material.dart';
import 'package:marvel/src/pages/about/about_page_bloc.dart';
import 'package:provider/provider.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<AboutPageBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('About'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Container(
                width: 100,
                child: Image.asset(
                  'assets/logo.png',
                ),
              ),
              Text(bloc.viewModel.developer, style: TextStyle(fontSize: 24)),
              SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(40.0),
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    bloc.viewModel.version,
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
