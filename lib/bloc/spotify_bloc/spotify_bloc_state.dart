part of 'spotify_bloc.dart';

@immutable
class SpotifyBlocState {
  final List<Category>? categories;
  final List<PlaylistSimple>? playListCategorie;
  final String statePage; 
  final List<Track>? songs;
  final List<Album>? albumsArtist;
  final List<Artist>? artist;
  final List<Track>? topTracks;
  final String? countryState;
  SpotifyBlocState({this.categories,this.playListCategorie, required this.statePage, this.songs,this.artist,this.albumsArtist,this.topTracks,this.countryState});


  SpotifyBlocState copyWith({
    final List<Category>? categories,
    final List<PlaylistSimple>? playListCategorie,
    final List<Track>? songs,
    final List<Album>? albumsArtist,
    final List<Artist>? artist,
    final List<Track>? topTracks,
    final String? countryState,
    required final String statePage 
  })=> SpotifyBlocState(
    categories: categories ?? this.categories,
    playListCategorie: playListCategorie?? this.playListCategorie,
    songs: songs?? this.songs,
    statePage: statePage, 
    albumsArtist: albumsArtist ?? this.albumsArtist,
    artist: artist ?? this.artist,
    topTracks: topTracks ?? this.topTracks,
    countryState: countryState ?? this.countryState
  );
  
}

class SpotifyBlocInitial extends SpotifyBlocState {
  SpotifyBlocInitial() : super(categories: [], statePage: 'categories', countryState: 'CO');
}




