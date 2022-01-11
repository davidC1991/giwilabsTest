import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/spotify.dart';
import 'package:wigilabs_app/bloc/spotify_bloc/spotify_bloc.dart';
import 'package:wigilabs_app/widgets/widgets.dart';





class ListMode extends StatelessWidget {
 
  final List<Track>? datas;
  final bool isTopTrackPage;
  const ListMode({this.datas,required this.isTopTrackPage});
  
  @override
  Widget build(BuildContext context) {
    print('inicio artista page');
    print(this.isTopTrackPage);
    final size = MediaQuery.of(context).size;
    return ListView.builder(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      itemCount:this.datas!.length,
      itemBuilder: (BuildContext context, int i) => listdatas(this.datas![i],size,context,this.isTopTrackPage)
    );
  }

  Widget listdatas(Track data, final size, BuildContext context, bool isTopTrackPage){
    final SpotifyBloc spotifyBloc = BlocProvider.of<SpotifyBloc>(context, listen: false);
    
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          //padding: EdgeInsets.all(5),
          margin: EdgeInsets.all(1),
          height: size.height*0.06,
          //color: Colors.blue,
          child: ListTile(
            visualDensity: VisualDensity(horizontal: 0.4,vertical: 0.0),
            isThreeLine: true,
            title:TextoCustomedWidget(text:data.name,size: 15.0, color:Colors.white,font: FontWeight.w300,align: TextAlign.left),
            subtitle:TextoCustomedWidget(text:'Duration: '+data.duration.toString().substring(0,8),size: 15.0, color:Colors.white,font: FontWeight.w300,align: TextAlign.left),
            leading: Icon(Icons.play_arrow),
            trailing: isTopTrackPage
                  ?Text('')
                  :MaterialButton(
                    child: TextoCustomedWidget(text:'See Artist',size: 15.0, color:Colors.blue[400],font: FontWeight.w300),
                    onPressed: (){
                      print('artista');
                      spotifyBloc.add(CleanArtistAndAlbumsAndTopTracks());
                      spotifyBloc.add(FetchArtitistAndAlbumsAndTopTracks(data.artists));  
                      Navigator.pushNamed(context, 'artist');
                  }
            ),//:Container(),
          )
        ),
        Divider()
      ],
    );
  }
}
              

