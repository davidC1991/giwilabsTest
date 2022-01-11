import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wigilabs_app/bloc/spotify_bloc/spotify_bloc.dart';

import 'package:wigilabs_app/bloc/user/user_bloc.dart';
import 'package:wigilabs_app/helpers/alertasRapidas.dart';
import 'package:wigilabs_app/models/apiWigiLab_model.dart';
import 'package:wigilabs_app/pages/home_Page.dart';
import 'package:wigilabs_app/preferences/preferencias_usuarios.dart';
import 'package:wigilabs_app/services/dataApiWigiLabs_service.dart';
import 'package:wigilabs_app/services/singIn_service.dart';
import 'package:wigilabs_app/services/spotify_service.dart';
import 'package:wigilabs_app/widgets/widgets.dart';
import 'package:wigilabs_app/models/user_model.dart' as userModel;


class LoginPage extends StatelessWidget {
  final TextEditingController emailController    = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final SingInService singInService = SingInService();
  final dataUserWigiLab = DataUserWigiLab();
  final SpotifyServices spotifyServices = SpotifyServices();
  final PreferenciasUsuario  prefs = new PreferenciasUsuario();

  
  @override
  Widget build(BuildContext context) {
    print(prefs.isUserOK);
    //prefs.setUser = '';
    final size     =  MediaQuery.of(context).size;
    final userBloc =  BlocProvider.of<UserBloc>(context, listen: false);
    final SpotifyBloc spotifyBloc = BlocProvider.of<SpotifyBloc>(context, listen: false);
    print('incio pagina sign in');
     if(prefs.isUserOK=='userOk'){
           
           final userModel.User newUser = userModel.User(name: prefs.nameAuthSocialNetwork!, email: prefs.mailAuthSocialNetwork! );
           final Usuario? userWigiLab = Usuario(nombre: prefs.nameAuthWigilab, apellido: prefs.surnameAuthWigilab,userProfileId: prefs.mailAuthWigilab,documentNumber: prefs.idAuthWigilab);
           userBloc.add( AuthenticateUser(newUser));
           userBloc.add( FetchDataWigiLab(userWigiLab,newUser));
           spotifyBloc.add(Fetchcategories('CO'));
           return HomePage();
        }


    return BlocBuilder<UserBloc,UserState>(
      builder: ( _ , state) {
        if(prefs.isUserOK=='userOk'){
           return HomePage();
        }else if (state.isUserAuthed!){
           prefs.setUser = 'userOk';
           return HomePage();
        } else{
          return signInPageWidget(size,context,userBloc);
        }  

     }                    
    );
  }
      
      
    

  Scaffold signInPageWidget(Size size, BuildContext context, UserBloc userBloc) {
    return Scaffold(
     body:SingleChildScrollView(
     child: Column(
       children: [
         titleApp(size),
         signInTitle(size),
         inputUser(size, userBloc),
         inputPassword(size, userBloc),
         buttonsRegisterAndSignIn(size, context, userBloc),
         singInButtonOtherAccounts(size,true,context,userBloc),
         singInButtonOtherAccounts(size,false,context,userBloc),
       ],
     ),
   )
  );
  }

  Container buttonsRegisterAndSignIn(Size size, BuildContext context, UserBloc userBloc) {
    return Container(
          padding: EdgeInsets.only(top: 0),
          alignment: Alignment.center,
          width: size.width * 0.4,
          child: Row(
            children: [
              singInButtonMail(context,userBloc),
              SizedBox(width: 10,),
              buttonSignUp(context, userBloc),
            ],
          ),
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
         
  buttonSignUp(BuildContext context, UserBloc userBloc) {
    return TextButton(
      onPressed: () {
        userBloc.add(SignUPWithEmail(email: ''));
        userBloc.add(SignUPWithEmail(password: ''));
        Navigator.pushReplacementNamed(context, 'signUp');
      },
      child: Text('Sign Up')
    );
  }

  Container inputUser(Size size, UserBloc userBloc) {
    return Container(
         margin: EdgeInsets.only(bottom: size.height * 0.01),
         width: size.width * 0.8,
         height: size.height * 0.08,
         //color: Colors.blue,
         child: formMethodLoggin(userBloc, emailController,isUserInput:true),
       );
  }

  Container inputPassword(Size size,UserBloc userBloc) {
    return Container(
         margin: EdgeInsets.only(bottom: size.height * 0.03),
         width: size.width * 0.8,
         height: size.height * 0.08,
         child: formMethodLoggin(userBloc,passwordController,isUserInput:false),
       );
  }

  TextFormField formMethodLoggin(UserBloc userBloc,TextEditingController controller, {bool isUserInput = true}) {
    return TextFormField(
          controller: controller,
          autofocus: false,
          obscureText: isUserInput?false:true,
          onChanged: (value){
             if(isUserInput) userBloc.add(SignUPWithEmail(email: value));
             if(!isUserInput) userBloc.add(SignUPWithEmail(password: value));
          },
          validator: ( value ){
            if ( value == null ) return 'this field is required';
            return value.length < 3 ? ' Unless three characters' : null;
          },
          autovalidateMode:  AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
             hintText: isUserInput?'Mail or User Name':'Password',
             labelText:isUserInput?'User Name':'Password',
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

  Widget singInButtonMail(BuildContext context, UserBloc userBloc){
    return ElevatedButton(
      onPressed: ()async{
         if(userBloc.state.email!= null && userBloc.state.password != null){
         Map<String, dynamic> resp = await singInService.singInFirebaseMail(userBloc.state.email!,userBloc.state.password!);
         if (resp['ok']){
               emailController.clear();
               passwordController.clear();
               FocusScope.of(context).unfocus();
               mensajePantalla('Successful Loggin');
               await getData(userBloc, context);
               Navigator.pushReplacementNamed(context, 'home');
            }else{
               FocusScope.of(context).unfocus();
               mensajePantalla(resp['message']);
            }
         }   
      },
      child: Text('Sing In')
    );
  }
  
  Widget singInButtonOtherAccounts(Size size, bool isLogginFacebook, BuildContext context, UserBloc userBloc){
   
    return GestureDetector(
      onTap: ()async{
        
        final User? isAuth =  isLogginFacebook?await signInFb(): await signInGoogle();
          await getData(userBloc, context, isAuth: isAuth);
          Navigator.pushReplacementNamed(context, 'home');
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

  getData(UserBloc userBloc, BuildContext context, {User? isAuth})async{
    final SpotifyBloc spotifyBloc = BlocProvider.of<SpotifyBloc>(context, listen:false);
    if (isAuth !=null ){
      final userModel.User newUser = userModel.User(name: isAuth.displayName!, email: isAuth.email! );
      final Usuario? userWigiLab = await getDataFromApiWigiLab();
      
      prefs.setIdAuthWigilab          = userWigiLab!.documentNumber!;
      prefs.setMailAuthWigilab        = userWigiLab.userProfileId!;
      prefs.setNameAuthWigilab        = userWigiLab.nombre!;
      prefs.setsurnameAuthWigilab     = userWigiLab.apellido!;
      prefs.setMailAuthSocialNetwork  = isAuth.email!;
      prefs.setNameAuthSocialNetwork  = isAuth.displayName!;
      userBloc.add( AuthenticateUser(newUser));
      userBloc.add( FetchDataWigiLab(userWigiLab,newUser));
      spotifyBloc.add(Fetchcategories('CO'));
     
       
    }else{
      final userModel.User newUser = userModel.User(name:'Not Name',email: userBloc.state.email! );
      final Usuario? userWigiLab = await getDataFromApiWigiLab();
      userBloc.add( FetchDataWigiLab(userWigiLab,newUser));
      spotifyBloc.add(Fetchcategories('CO'));
      prefs.setIdAuthWigilab          = userWigiLab!.documentNumber!;
      prefs.setMailAuthWigilab        = userWigiLab.userProfileId!;
      prefs.setNameAuthWigilab        = userWigiLab.nombre!;
      prefs.setsurnameAuthWigilab     = userWigiLab.apellido!;
      prefs.setMailAuthSocialNetwork  = userBloc.state.email!;
      prefs.setNameAuthSocialNetwork  = 'Not Name';
    }
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