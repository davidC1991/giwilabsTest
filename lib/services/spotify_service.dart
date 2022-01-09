import 'package:spotify/spotify.dart';
import 'dart:io';

// import 'package:oauth2/oauth2.dart' as oauth2;

class SpotifyServices{
  String clientId = "d0aded15712d4c9bb0819a5bc7094e81";
  String clientSecret = "f18d5e9e87e641d5bbdefc885ea8d614"; 
  
  
 Future<List<Category>?> getCategories()async{
        final credentials = SpotifyApiCredentials(this.clientId, this.clientSecret);
        final spotify = SpotifyApi(credentials);
        final categoriesList =  spotify.categories.list();
        final categories = await categoriesList.all();
        final List<Category> categoriesResp = categories.toList();
        return categoriesResp;
  }
        
        
        
        

 
}

