import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:wigilabs_app/models/signInMail_model.dart';

class SingInService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FacebookAuth _facebookSignIn = FacebookAuth.instance;
  
  singInFirebaseMail(String email, String password)async{
   ResponseSingInMail detailsComicResponse;
    // add package http in pubspec
    final String _firebaseToken = 'AIzaSyCcHZUxUrB0mAsPuaDAuQ6euV3TxrYaph4';

    final authData = {
         'email'    : email,
         'password' : password,
         'returnSecureToken' : true,
    };
    var url_2 = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken');
    final resp = await http.post(
      url_2,
      body: json.encode(authData)
    );
    //Map<String, dynamic> decodeResp = json.decode(resp.body);
    //here you must set up the model to the response and using de right fromJson Class
    //print(resp.body);
    try {
      detailsComicResponse = ResponseSingInMail.fromJson2(resp.body);
      print('aqui-error');
      print(detailsComicResponse.error!.code);
    } catch (e) {
      detailsComicResponse = ResponseSingInMail.fromJson(resp.body);
      print(detailsComicResponse.email);
      print('aqui1');
    }
      
      
  }

  Future<User?>singInFirebaseGoogle()async{
     
    try {
      final account = await this._googleSignIn.signIn();
      if (account == null){
        print('error');
      }
      final googleAuth = await account!.authentication;

      final OAuthCredential oAuthCredential =  GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken
      );

      final userCredential = await _auth.signInWithCredential(oAuthCredential);
      //print(userCredential.user);
      return userCredential.user!;

    } on FirebaseAuthException catch (e) {
      print(e);
    }
    return null;
  }

  Future<User?> singInFirebaseFb()async{
     
    try {
      final result = await _facebookSignIn.login();

      if (result.status == LoginStatus.success){
         final oAuthCredential = FacebookAuthProvider.credential(result.accessToken!.token);
         final UserCredential userCredential = await _auth.signInWithCredential(oAuthCredential);
         print(userCredential.user);
         return userCredential.user!;
      }

    } on FirebaseAuthException catch (e) {
      print(e);
    }
   // return null;
  }

  User? get user => _auth.currentUser;
  //User get auth => _auth.;

  signOutGoogle() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
  
  signOutFb() async {
    try {
      await _facebookSignIn.logOut();
      await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}