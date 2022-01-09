part of 'spotify_bloc.dart';

@immutable
abstract class SpotifyBlocState {
  final List<Category>? categories;

  SpotifyBlocState({required this.categories});
}

class SpotifyBlocInitial extends SpotifyBlocState {
  SpotifyBlocInitial() : super(categories: []);
}

class CategoriesState extends SpotifyBlocState{
  final List<Category>? newCategories;
  CategoriesState(this.newCategories) : super(categories: newCategories);
}