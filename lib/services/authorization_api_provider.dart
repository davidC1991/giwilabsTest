import 'dart:async';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' show Client;

class AuthorizationApiProvider {
  Client client = Client();

  static String url = "https://accounts.spotify.com/authorize";
  static String client_id = "d0aded15712d4c9bb0819a5bc7094e81";
  static String response_type = "code";
  static String redirect_uri = "callback:/";
  static String scope = "playlist-read-private playlist-read-collaborative";
  static String state = "6";

  String urlDireccion = "$url" +
      "?client_id=$client_id" +
      "&response_type=$response_type" +
      "&redirect_uri=$redirect_uri" +
      "&scope=$scope" +
      "&state=$state"; 
      
  Future<String?> fetchCode() async {
    final response = await FlutterWebAuth.authenticate( url: urlDireccion, callbackUrlScheme: "callback", preferEphemeral: false);
    final error = Uri.parse(response).queryParameters['error'];
    if (error == null) {
      final code = Uri.parse(response).queryParameters['code'];
      print(code);
      return code;
    } else {
      print("Error al autenticar");
      return error;
    }
  }
}
