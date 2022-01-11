part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class AuthenticateUser extends UserEvent{
  final User user;
  AuthenticateUser(this.user);
}

class FetchDataWigiLab extends UserEvent{
  final Usuario? wigilabUser;
  final User user;
  FetchDataWigiLab(this.wigilabUser,this.user);
}

class SignUPWithEmail extends UserEvent{
  final String? password;
  final String? email;
  final String? name;
  final String? surname;
  final bool? isRegisteredEmail;

  SignUPWithEmail({this.password, this.email, this.name, this.surname,this.isRegisteredEmail = false});
}

class UserRegisteredEmail extends UserEvent{
  final bool userRegistered;
  UserRegisteredEmail(this.userRegistered);
}

class ResetUser extends UserEvent{}

