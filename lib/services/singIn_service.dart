import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class SingInService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FacebookAuth _facebookSignIn = FacebookAuth.instance;
  final String _firebaseToken = 'AIzaSyCcHZUxUrB0mAsPuaDAuQ6euV3TxrYaph4';

   Future <Map <String, dynamic>> singUpFirebaseMail(String email, String password) async {

    final authData = {
      'email'             : email,
      'password'          : password,
      'returnSecureToken' : true,

    };
    
    var url_2 = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken');
    final resp = await http.post(
      url_2,
      body: json.encode(authData)
    );
      

   Map<String, dynamic> decodeResp = json.decode(resp.body);

  
    print(decodeResp);
    if (decodeResp.containsKey('localId')){
      //_prefs.token = decodeResp['localId'];
      //Todo: salvar el token en el storage
      return {'ok': true , 'token' : decodeResp['localId']};
    }else {
      return {'ok' : false, 'message' : decodeResp['error']['message']};
    }
    
  }


  Future <Map <String, dynamic>> singInFirebaseMail(String email, String password)async{
 
  
    

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
    Map<String, dynamic> decodeResp = json.decode(resp.body);
    if (decodeResp.containsKey('localId')){
        return {'ok': true , 'token' : decodeResp['localId']};
    }else {
        return {'ok' : false, 'message' : decodeResp['error']['message']};
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