import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wigilabs_app/bloc/spotify_bloc/spotify_bloc.dart';
import 'package:wigilabs_app/bloc/user/user_bloc.dart';
import 'package:wigilabs_app/widgets/serach_delegate.dart';



import 'package:wigilabs_app/widgets/widgets.dart';

class HomePage extends StatelessWidget {

  
  
  @override
  Widget build(BuildContext context) {
    final UserBloc userBloc = BlocProvider.of<UserBloc>(context, listen: false);
    final SpotifyBloc spotifyBloc = BlocProvider.of<SpotifyBloc>(context, listen: true);
    final size = MediaQuery.of(context).size;
    print('inicio pagina categoria home');
 
    return Scaffold(
      appBar: AppBar(
        title: Text('App WigiLab'),
        actions: [
          IconButton(
            onPressed: ()=> showSearch(context: context, delegate: SpotifySearchDelegate()),
            icon: Icon(Icons.search)
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top:10),
        width:size.width * 1,
        height: size.height * 1,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TituloInfo(size:size, texto: 'User Information',isCountryChose: false,),
              infoUsuario(size, userBloc.state, isUserWigiLab: true),
              infoUsuario(size, userBloc.state, isUserWigiLab: false),
              TituloInfo(size:size, texto: 'Categories',isCountryChose: true),
              GridModeCategory(categories:spotifyBloc.state.categories)
            ],
          ),
        ),
      ),
    );
  }

  

  Container infoUsuario(Size size, UserState user , {bool isUserWigiLab = true}) {
    final List<String> nombreCompleto = user.user!.name.split(' ');
    String nombre = nombreCompleto.length == 2
                    ?nombreCompleto[0]
                    :nombreCompleto.length == 3? nombreCompleto[0]
                    :nombreCompleto[0] + nombreCompleto[1]; 
    String apellido = nombreCompleto.length == 2
                    ?nombreCompleto[1]
                    :nombreCompleto.length == 3? nombreCompleto[1] + nombreCompleto[2]
                    :nombreCompleto[2] + nombreCompleto[3]; 
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      width:size.width * 0.68,
      height: size.height * 0.15,
      child: Card(
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(top: 5,bottom: 5),
            child: isUserWigiLab?Text('WigiLab User'):Text('Logged Usser'),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isUserWigiLab?user.userWigiLab==null?Container(child: Text('Error 1 from Server'),):Text('Name: ${user.userWigiLab!.nombre!}'):Text('Name: $nombre'),
              isUserWigiLab?user.userWigiLab==null?Container(child: Text('Error 1 from Server'),):Text('Surname: ${user.userWigiLab!.apellido!}'):Text('Surname: $apellido'),
              isUserWigiLab?user.userWigiLab==null?Container(child: Text('Error 1 from Server'),):Text('Mail: ${user.userWigiLab!.userProfileId!}'):Text('Mail: ${user.user!.email}'),
              isUserWigiLab?user.userWigiLab==null?Container(child: Text('Error 1 from Server'),):Text('Id Card: ${user.userWigiLab!.documentNumber!}'):Text(''),
             
            ],
          ),
        ),
      ),
    );
  }

  
  

}
          
                      
 
