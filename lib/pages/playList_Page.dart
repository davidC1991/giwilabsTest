import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wigilabs_app/bloc/spotify_bloc/spotify_bloc.dart';
import 'package:wigilabs_app/widgets/widgets.dart';

class PlayListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SpotifyBloc spotifyBloc = BlocProvider.of<SpotifyBloc>(context, listen: true);
   
  
    return Scaffold(
      appBar: AppBar(title: Text('Play list')),
      body: spotifyBloc.state.playListCategorie==null
            ?Center(child: Text('Error Connection'),)
            :spotifyBloc.state.playListCategorie!.isEmpty
            ?Center(child: CircularProgressIndicator())
            :SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: GridModeplayList(playLists: spotifyBloc.state.playListCategorie),
                   ),
                  ],
                ),
              ),
            )
   );
  }
}