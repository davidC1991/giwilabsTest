part of 'user_bloc.dart';

@immutable
abstract class UserState {
  final bool isUserAuthed;
  final User? user;
  final Usuario? userWigiLab; 

  UserState({this.isUserAuthed = false, this.user, this.userWigiLab});

}

class UserInitialState extends UserState {
   UserInitialState():super(user: null, isUserAuthed: false);
}

class UserSetState extends UserState{
  final User userAuthed;
  UserSetState(this.userAuthed):super(user: userAuthed, isUserAuthed: true);
}

class UserWigiLabState extends UserState {
  final Usuario? userWigiLabs;
  final User user;
  UserWigiLabState(this.userWigiLabs,this.user):super(userWigiLab: userWigiLabs, isUserAuthed: true,user: user);
}

