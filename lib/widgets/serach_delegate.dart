import 'package:flutter/material.dart';
import 'package:spotify/spotify.dart';
import 'package:wigilabs_app/services/spotify_service.dart';

class SpotifySearchDelegate extends SearchDelegate{
  SpotifyServices spotifyServices = SpotifyServices();
  
  @override
  String get searchFieldLabel => 'Search Artists';
  
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: ()=> query = '',
        icon: Icon(Icons.clear)
      ),
    ];
  }
        

  @override
  Widget buildLeading(BuildContext context) {
   
    return IconButton(
        onPressed: (){
          close(context, null);
        },
        icon: Icon(Icons.arrow_back)
      );
  }

  @override
  Widget buildResults(BuildContext context) {
   
    return Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    
    if(query.isEmpty){
      return _emptyContainer();
    }
    return FutureBuilder(
      future: spotifyServices.getSearches(query),
      builder: ( _ , AsyncSnapshot<List<dynamic>> snapshot){
        if (!snapshot.hasData || snapshot.data!.isEmpty) return _emptyContainer();
        print(snapshot.data!.length);
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (BuildContext context, int index) {
            return resultSearched(context,snapshot.data![index]);
          },
        );
      }
    );
  }

 Widget resultSearched(BuildContext context, Artist artist){
  final Size size = MediaQuery.of(context).size; 
  return ListTile(
    leading: FadeInImage(
      placeholder: AssetImage('assets/loading.gif'),
      image: NetworkImage(artist.images != null && artist.images!.isNotEmpty?artist.images![0].url!:'https://www.segelectrica.com.co/wp-content/themes/consultix/images/no-image-found-360x250.png'), 
      width: size.width*0.1,
      height:size.height*0.08,
      fit: BoxFit.contain
     ),
     title: artist.name==null?Text('Not Name'):Text(artist.name!),
     subtitle: artist.id==null?Text('Not Name'):Text(artist.id!)
  ); 
 }
    

 Widget _emptyContainer(){
   return Container(
        child: Center(
          child: Icon(Icons.my_library_music_outlined, color: Colors.black38, size: 100,),
         )
      );
 }
}