import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wigilabs_app/bloc/user/user_bloc.dart';
import 'package:wigilabs_app/preferences/preferencias_usuarios.dart';
import 'package:wigilabs_app/routes/appRoutes.dart';
import 'package:firebase_core/firebase_core.dart';


import 'bloc/spotify_bloc/spotify_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
   
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ( _ ) => UserBloc()),
        BlocProvider(create: ( _ ) => SpotifyBloc()),
      ],
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
          indicatorColor:Colors.white,
         
        ),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        initialRoute: 'loggin',
        routes: appRoutes
      ),
    );
  }
}
