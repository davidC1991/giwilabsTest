import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:spotify/spotify.dart';
import 'package:wigilabs_app/services/spotify_service.dart';

part 'spotify_bloc_event.dart';
part 'spotify_bloc_state.dart';

class SpotifyBloc extends Bloc<SpotifyBlocEvent, SpotifyBlocState> {
  SpotifyBloc() : super(SpotifyBlocInitial()) {
    final SpotifyServices spotifyServices = SpotifyServices();
    on<Fetchcategories>((event, emit)async {
      final categories = await spotifyServices.getCategories(event.country!);
      emit(state.copyWith(statePage: '', categories: categories));
    });

    on<FetchPlayListByCategorie>((event, emit) async{
      try {
        final playList = await spotifyServices.getPlayListCategorie(event.categoryId!.id!);
        emit(state.copyWith(playListCategorie: playList, statePage: 'playList'));
      } catch (e) {
        emit(state.copyWith(playListCategorie: null, statePage: 'playList'));
          
      }
    }); 

    on<FetchSongsByPlayList>((event, emit) async {
       final songs = await spotifyServices.getSongs(event.playListId.id!);
       emit(state.copyWith(statePage: 'songs', songs: songs));  
    });

    on<FetchArtitistAndAlbumsAndTopTracks>((event, emit) async{
      final albums = await spotifyServices.getAlbumsArtist(event.artist![0].id!);
      final topTracks = await spotifyServices.getTopTracks(event.artist![0].id!);
      print(event.artist!.length);
      emit(state.copyWith(statePage: '', albumsArtist: albums, artist: event.artist, topTracks: topTracks));
    });

    on<ChangeCountry>((event, emit) {
      emit(state.copyWith(statePage: '', countryState: event.countryState));  
    });
    on<CleanCategories>((event, emit) {
      emit(state.copyWith(statePage: 'categories', categories: []));
    });

    on<CleanSongs>((event, emit) {
      emit(state.copyWith(statePage: 'songs', songs: []));
    });

    on<CleanPlayList>((event, emit) {
      emit(state.copyWith(statePage: 'playList', playListCategorie: []));
    });

    on<CleanArtistAndAlbumsAndTopTracks>((event, emit) {
      emit(state.copyWith(statePage: 'playList', albumsArtist: [], artist: [], topTracks: []));
    });

    
  }
     

}
