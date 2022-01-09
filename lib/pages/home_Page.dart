import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wigilabs_app/bloc/spotify_bloc/spotify_bloc.dart';
import 'package:wigilabs_app/bloc/user/user_bloc.dart';

import 'package:wigilabs_app/services/dataApiWigiLabs_service.dart';
import 'package:wigilabs_app/services/singIn_service.dart';
import 'package:wigilabs_app/services/spotify_service.dart';
import 'package:wigilabs_app/widgets/grid_mode.dart';
import 'package:wigilabs_app/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  final dataUserWigiLab = DataUserWigiLab();
  final SingInService singInService = SingInService();
  final SpotifyServices spotifyServices = SpotifyServices();
  @override
  Widget build(BuildContext context) {
    final UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    final SpotifyBloc spotifyBloc = BlocProvider.of<SpotifyBloc>(context);
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      appBar: AppBar(title: Text('App WigiLab')),
      body: Container(
        margin: EdgeInsets.only(top:10),
        width:size.width * 1,
        height: size.height * 1,
        child: SingleChildScrollView(
          child: Column(
            children: [
              tituloInfo(size, texto: 'Información de Usuario'),
              infoUsuario(size, userBloc.state, isUserWigiLab: true),
              infoUsuario(size, userBloc.state, isUserWigiLab: false),
              tituloInfo(size, texto: 'Categoria'),
              GridMode(categories: spotifyBloc.state.categories)
            ],
          ),
        ),
      ),
    );
  }

  Container tituloInfo(Size size,{String texto = ''}) {
    return Container(
              margin: EdgeInsets.only(top: 10, bottom: 15),
               width:size.width * 1,
               height: size.height * 0.07,
               color: Colors.grey.withOpacity(0.2),
               child: ListTile(
                 title: TextoCustomedWidget(text:texto,size: 20.0, color:Colors.black,font: FontWeight.w100),
               ),
            );
  }

  Container infoUsuario(Size size, UserState user , {bool isUserWigiLab = true}) {
    final List<String> nombreCompleto = user.user!.name.split(' ');
    String nombre = nombreCompleto[0]+' '+nombreCompleto[1]; 
    String apellido = nombreCompleto[2]+' '+nombreCompleto[3]; 
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      width:size.width * 0.68,
      height: size.height * 0.15,
      child: Card(
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(top: 5,bottom: 5),
            child: isUserWigiLab?Text('Infomación Usuario WigiLab'):Text('Infomación Usuario Registrado'),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isUserWigiLab?Text('Nombre: ${user.userWigiLab!.nombre!}'):Text('Nombre: $nombre'),
              isUserWigiLab?Text('Apellidos: ${user.userWigiLab!.apellido!}'):Text('Apellidos: $apellido'),
              isUserWigiLab?Text('Correo: ${user.userWigiLab!.userProfileId!}'):Text('Correo: ${user.user!.email}'),
              isUserWigiLab?Text('Cedula: ${user.userWigiLab!.documentNumber!}'):Text(''),
             
            ],
          ),
        ),
      ),
    );
  }

}
          
                      
 
