part of 'user_bloc.dart';

@immutable
abstract class UserState {
  final bool userAuthed;
  final User? user;

  UserState({this.userAuthed = false, this.user});

}

class UserInitialState extends UserState {
   UserInitialState():super(user: null, userAuthed: false);
}
