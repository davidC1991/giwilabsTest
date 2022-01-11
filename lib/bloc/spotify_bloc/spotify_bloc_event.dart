part of 'spotify_bloc.dart';

@immutable
abstract class SpotifyBlocEvent {}

class Fetchcategories extends SpotifyBlocEvent{
  final String? country;
  Fetchcategories(this.country);
}

class FetchPlayListByCategorie extends SpotifyBlocEvent{
  final Category? categoryId;
  FetchPlayListByCategorie(this.categoryId);
}

class FetchSongsByPlayList extends SpotifyBlocEvent{
  final PlaylistSimple playListId;
  FetchSongsByPlayList(this.playListId); 
}

class FetchArtitistAndAlbumsAndTopTracks extends SpotifyBlocEvent{
  final List<Artist>? artist;
  FetchArtitistAndAlbumsAndTopTracks(this.artist);
}
  
class ChangeCountry extends SpotifyBlocEvent{
  final String? countryState;
  ChangeCountry({this.countryState});
}  



class CleanCategories extends SpotifyBlocEvent{}
class CleanSongs extends SpotifyBlocEvent{}
class CleanPlayList extends SpotifyBlocEvent{}
class CleanArtistAndAlbumsAndTopTracks extends SpotifyBlocEvent{}
