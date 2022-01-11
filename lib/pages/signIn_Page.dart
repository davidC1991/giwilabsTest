import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wigilabs_app/bloc/spotify_bloc/spotify_bloc.dart';

import 'package:wigilabs_app/bloc/user/user_bloc.dart';
import 'package:wigilabs_app/models/apiWigiLab_model.dart';
import 'package:wigilabs_app/pages/home_Page.dart';
import 'package:wigilabs_app/services/dataApiWigiLabs_service.dart';
import 'package:wigilabs_app/services/singIn_service.dart';
import 'package:wigilabs_app/services/spotify_service.dart';
import 'package:wigilabs_app/widgets/widgets.dart';
import 'package:wigilabs_app/models/user_model.dart' as userModel;


class LoginPage extends StatelessWidget {
 
  final SingInService singInService = SingInService();
  final dataUserWigiLab = DataUserWigiLab();
  final SpotifyServices spotifyServices = SpotifyServices();
  
  @override
  Widget build(BuildContext context) {

    final size     =  MediaQuery.of(context).size;
    final userBloc =  BlocProvider.of<UserBloc>(context, listen: false);
  
    return BlocBuilder<UserBloc,UserState>(
      builder: ( _ , state)=>state.isUserAuthed?HomePage():signInPageWidget(size,context,userBloc)
    );
  }
      
      
    //return this.singInService.user?.uid != null?HomePage():signInPageWidget(size,context);

  Scaffold signInPageWidget(Size size, BuildContext context, UserBloc userBloc) {
    return Scaffold(
     body:SingleChildScrollView(
     child: Column(
       children: [
         
         titleApp(size),
         signInTitle(size),
         inputUser(size),
         inputPassword(size),
         singInButtonMail(size),
         singInButtonOtherAccounts(size,true,context,userBloc),
         singInButtonOtherAccounts(size,false,context,userBloc),
       ],
     ),
   )
  );
  }
         

  Widget signInTitle(Size size){
    return TextoCustomedWidget(text:'Loggin',size: 15.0, color:Colors.black54,font: FontWeight.w700, padding: EdgeInsets.only(bottom: 15.0),);
  }

  Container titleApp(Size size) {
    return Container(
      padding: EdgeInsets.only(top: size.height * 0.2),
         alignment: Alignment.bottomCenter,
         margin: EdgeInsets.only(bottom: size.height * 0.04),
         width: size.width * 1,
         height: size.height * 0.4,
         child: TextoCustomedWidget(text:'WigiLabs Test App',size: 40.0, color:Colors.white,font: FontWeight.w100),
       );
  }
         

  Container inputUser(Size size) {
    return Container(
         margin: EdgeInsets.only(bottom: size.height * 0.01),
         width: size.width * 0.8,
         height: size.height * 0.08,
         //color: Colors.blue,
         child: formMethodLoggin(true),
       );
  }

  Container inputPassword(Size size) {
    return Container(
         margin: EdgeInsets.only(bottom: size.height * 0.03),
         width: size.width * 0.8,
         height: size.height * 0.08,
         child: formMethodLoggin(false),
       );
  }

  TextFormField formMethodLoggin( bool isUserInput) {
    return TextFormField(
          autofocus: false,
          obscureText: isUserInput?false:true,
          onChanged: (value){
          },
          validator: ( value ){
            if ( value == null ) return 'this field is required';
            return value.length < 3 ? ' Unless three characters' : null;
          },
          autovalidateMode:  AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
             hintText: isUserInput?'Mail or User Name':'Password',
             labelText:isUserInput?'User Name':'´Password',
             suffixIcon:  isUserInput?Icon(Icons.group_outlined):Icon(Icons.password),
             border: OutlineInputBorder(
                borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                )
           )
          )
        );
  }

  Widget singInButtonMail(Size size){
    return ElevatedButton(
      onPressed: ()=>singInService.singInFirebaseMail('david@hotmail.es','123456'),
      child: Text('Sing In')
    );
  }

  Widget singInButtonOtherAccounts(Size size, bool isLogginFacebook, BuildContext context, UserBloc userBloc){
    final SpotifyBloc spotifyBloc = BlocProvider.of<SpotifyBloc>(context);
    return GestureDetector(
      onTap: ()async{
        
        final User? isAuth =  isLogginFacebook?await signInFb(): await signInGoogle();
        

        // ignore: unnecessary_null_comparison
        if (isAuth!.uid != null){
          final userModel.User newUser = userModel.User(name: isAuth.displayName!, email: isAuth.email! );
          userBloc.add( AuthenticateUser(newUser));
          final Usuario? userWigiLab = await getDataFromApiWigiLab();
          userBloc.add( FetchDataWigiLab(userWigiLab,newUser));
          spotifyBloc.add(Fetchcategories('CO'));
          Navigator.pushReplacementNamed(context, 'home');
        }
      },
      child: Container(
      margin: EdgeInsets.only(top: 25),  
      height: isLogginFacebook?size.height*0.05:size.height*0.045,
      width: isLogginFacebook?size.width*0.5:size.width*0.77,
      decoration: BoxDecoration(
         image:DecorationImage(
            image: AssetImage(isLogginFacebook?'assets/facebook.png':'assets/Google.png'),
            fit: BoxFit.cover 
           ), 
         borderRadius: BorderRadius.circular(10)
        ),
      ),
    );
  }
  signInGoogle() async {
    return await singInService.singInFirebaseGoogle();
  }
  signInFb() async {
    return await singInService.singInFirebaseFb();
  }
  getDataFromApiWigiLab() async {
    return await dataUserWigiLab.getDataFromApiWigiLabs();
  }
}