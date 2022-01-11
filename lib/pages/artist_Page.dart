import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/spotify.dart';
import 'package:wigilabs_app/bloc/spotify_bloc/spotify_bloc.dart';
import 'package:wigilabs_app/widgets/widgets.dart';


class ArtistPage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final SpotifyBloc spotifyBloc = BlocProvider.of<SpotifyBloc>(context, listen: true);
    
    return Scaffold(
      appBar:AppBar(title: Text('Artist Details')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            spotifyBloc.state.artist!.isEmpty
            ?Center(child: CircularProgressIndicator())
            :detailsArtist(size, spotifyBloc.state.artist![0]),
            TituloInfo(size:size, texto: 'Top Tracks',isCountryChose: false),
            ListMode(datas: spotifyBloc.state.topTracks ==null ? []:spotifyBloc.state.topTracks,isTopTrackPage: true),
            TituloInfo(size:size, texto: 'Albums',isCountryChose: false),
            spotifyBloc.state.albumsArtist!.isEmpty
            ?CircularProgressIndicator()
            :GridModealbum(albums: spotifyBloc.state.albumsArtist)
          ],
        ),
      ),
    );
  }

  Widget detailsArtist(Size size, Artist artist) {
    return Container(
       padding: EdgeInsets.only(top:10),
       child: Row(
        children: [
         
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: FadeInImage(
              placeholder: AssetImage('assets/loading.gif'),
              image: NetworkImage(artist.images != null && artist.images!.isNotEmpty?artist.images![0].url!:'https://www.segelectrica.com.co/wp-content/themes/consultix/images/no-image-found-360x250.png'), 
              width: size.width*0.3,
              height:size.height*0.19,
              fit: BoxFit.fill
            ),
          ),
           Container(
            alignment: Alignment.topLeft,
            width: size.width * 0.5,
            height: size.height * 0.15,
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children: [
                TextoCustomedWidget(padding:EdgeInsets.only(top:2),text:artist.name==null?'Not Name':artist.name!.toUpperCase(),size: 18.0, color:Colors.white,font: FontWeight.w300),
                TextoCustomedWidget(padding:EdgeInsets.only(top:2),text:artist.followers==null?'Followers: Not Available':'Followers:'+artist.followers!.toString(),size: 15.0, color:Colors.white,font: FontWeight.w200),
                TextoCustomedWidget(padding:EdgeInsets.only(top:2),text:artist.popularity==null?'Popularity: Not Available':'Popularity:'+artist.popularity!.toString(),size: 15.0, color:Colors.white,font: FontWeight.w200),
                TextoCustomedWidget(padding:EdgeInsets.only(top:2),text:artist.genres==null?'Genre: Not Available':'Genre:'+artist.genres![0].toString(),size: 15.0, color:Colors.white,font: FontWeight.w200),
                TextoCustomedWidget(padding:EdgeInsets.only(top:2),text:artist.type==null?'Type: Not Available':'Type: '+artist.type![0].toString().toUpperCase(),size: 15.0, color:Colors.white,font: FontWeight.w200),
              ],
            ),
          ),
        ],
      ),
      );
        
  }
}


