part of 'user_bloc.dart';

@immutable
 class UserState {
  final bool? isUserAuthed;
  final User? userModel;
  final Usuario? userWigiLab; 
  final String? password;
  final String? email;
  final String? name;
  final String? surname;
  final bool? isRegisteredEmail;

  UserState({this.isUserAuthed = false, this.userModel, this.userWigiLab, this.surname,this.email,this.name,this.password, this.isRegisteredEmail});

  UserState copyWith({
    final bool? isUserAuthed,
    final User? userModel,
    final Usuario? userWigiLab,
    final String? password,
    final String? email,
    final String? name,
    final String? surname,
    final bool? isRegisteredEmail
   
  })=>UserState(
     isUserAuthed: isUserAuthed ?? this.isUserAuthed,
     userModel: userModel ?? this.userModel,
     userWigiLab: userWigiLab ?? this.userWigiLab,
     password: password ?? this.password,
     email: email ?? this.email,
     name: name ?? this.name,
     surname: surname ?? this.surname,
     isRegisteredEmail: isRegisteredEmail ?? this.isRegisteredEmail
  );

}

class UserInitialState extends UserState {
   UserInitialState():super(userModel: null, isUserAuthed: false, isRegisteredEmail: false);
}

class UserSetState extends UserState{
  final User userAuthed;
  UserSetState(this.userAuthed):super(userModel: userAuthed, isUserAuthed: true);
}

class UserWigiLabState extends UserState {
  final Usuario? userWigiLabs;
  final User userModel;
  UserWigiLabState(this.userWigiLabs,this.userModel):super(userWigiLab: userWigiLabs, isUserAuthed: true,userModel: userModel);
}

