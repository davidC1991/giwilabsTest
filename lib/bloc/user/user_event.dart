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


