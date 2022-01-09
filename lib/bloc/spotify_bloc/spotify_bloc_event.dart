part of 'spotify_bloc.dart';

@immutable
abstract class SpotifyBlocEvent {}

class Fetchcategories extends SpotifyBlocEvent{
  final List<Category>? categories;
  Fetchcategories(this.categories);
}
