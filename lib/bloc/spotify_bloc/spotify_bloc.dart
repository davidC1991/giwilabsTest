import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:spotify/spotify.dart';
import 'package:wigilabs_app/services/spotify_service.dart';

part 'spotify_bloc_event.dart';
part 'spotify_bloc_state.dart';

class SpotifyBloc extends Bloc<SpotifyBlocEvent, SpotifyBlocState> {
  SpotifyBloc() : super(SpotifyBlocInitial()) {
    
    on<Fetchcategories>((event, emit) {
      emit(CategoriesState(event.categories));
    });
    

  }
}
