import 'package:spotify/spotify.dart';


// import 'package:oauth2/oauth2.dart' as oauth2;

class SpotifyServices{
  String clientId = "d0aded15712d4c9bb0819a5bc7094e81";
  String clientSecret = "f18d5e9e87e641d5bbdefc885ea8d614"; 
  
  
 Future<List<Category>?> getCategories(String country)async{
        final credentials = SpotifyApiCredentials(this.clientId, this.clientSecret);
        final spotify = SpotifyApi(credentials);
        try {
          final categoriesList =  spotify.categories.list(country: country);
          final categories = await categoriesList.first(20);
          final List<Category> categoriesResp = categories.items!.toList();
          return categoriesResp;
        } catch (e) {
          print(e);
          return null;  
        }
  }

  Future<List<PlaylistSimple>?> getPlayListCategorie(String idCategorie)async{
        final credentials = SpotifyApiCredentials(this.clientId, this.clientSecret);
        final spotify = SpotifyApi(credentials);
       try {
        final playList =  spotify.playlists.getByCategoryId(idCategorie);
        final playListResp = await playList.first(20);
        final List<PlaylistSimple> lisPlayLists = playListResp.items!.toList();
        return lisPlayLists;
       } catch (e) {
          print('error en play list $e');
          return null; 
         
       }
  }
  
  Future<List<Track>?> getSongs(String idPlayList)async{
        final credentials = SpotifyApiCredentials(this.clientId, this.clientSecret);
        final spotify = SpotifyApi(credentials);
        try {
          final songs =  spotify.playlists.getTracksByPlaylistId(idPlayList);
          final songsResp = await songs.all();
          final List<Track> listSongs = songsResp.toList();
          return listSongs;
        } catch (e) {
          print(e);
          return null;  
        }
  } 
   
  Future<Artist?> getArtist(String artistId)async{
        final credentials = SpotifyApiCredentials(this.clientId, this.clientSecret);
        final spotify = SpotifyApi(credentials);
        try {
          final artist =  await spotify.artists.get(artistId);
          return artist;
        } catch (e) {
          print(e);
          return null;  
        }
  } 

  Future<List<Album>?> getAlbumsArtist(String artistId)async{
        final credentials = SpotifyApiCredentials(this.clientId, this.clientSecret);
        final spotify = SpotifyApi(credentials);
        try {
          final album =  spotify.artists.albums(artistId);
          final albumResp = await album.all();
          final List<Album> listAlbum = albumResp.toList();
          return listAlbum;
        } catch (e) {
          print(e);
          return null;  
        }
  } 
  Future<List<Track>?> getTopTracks(String artistId)async{
        final credentials = SpotifyApiCredentials(this.clientId, this.clientSecret);
        final spotify = SpotifyApi(credentials);
        try {
          final topTracks = await  spotify.artists.getTopTracks(artistId, 'CO');
          return topTracks.toList();
        } catch (e) {
          print(e);
          return null;  
        }
  } 

  Future<List<dynamic>> getSearches(String query)async{
        final credentials = SpotifyApiCredentials(this.clientId, this.clientSecret);
        final spotify = SpotifyApi(credentials);
        try {
          final search = spotify.search.get(query, types: [SearchType.artist]);
          final searchResp = await search.first(20);
          return searchResp[0].items!.toList();
        } catch (e) {
          print(e);
          return [];  
        }
  } 

}


     
        

 

