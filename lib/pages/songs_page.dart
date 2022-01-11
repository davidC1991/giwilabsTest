import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wigilabs_app/bloc/spotify_bloc/spotify_bloc.dart';
import 'package:wigilabs_app/widgets/widgets.dart';


class SongsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   final SpotifyBloc spotifyBloc = BlocProvider.of<SpotifyBloc>(context, listen: true);
   return Scaffold(
      appBar: AppBar(title: Text('Song')),
       body:spotifyBloc.state.songs!.isNotEmpty
          ?SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListMode(datas: spotifyBloc.state.songs, isTopTrackPage: false),
                ],
              ),
            ),
          )
          :Center(child: CircularProgressIndicator())
    );
  }
}