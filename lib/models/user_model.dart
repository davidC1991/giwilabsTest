import 'package:firebase_auth/firebase_auth.dart';

class User{
  final String name;
  final String? displayName;
  final String email;

  User({
    required this.name,
    this.displayName,
    required this.email
  });
}