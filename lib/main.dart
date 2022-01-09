import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wigilabs_app/bloc/user/user_bloc.dart';
import 'package:wigilabs_app/routes/appRoutes.dart';
import 'package:firebase_core/firebase_core.dart';

import 'bloc/spotify_bloc/spotify_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ( _ ) => UserBloc()),
        BlocProvider(create: ( _ ) => SpotifyBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        initialRoute: 'login',
        routes: appRoutes
      ),
    );
  }
}
