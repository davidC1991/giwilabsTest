import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wigilabs_app/pages/home_Page.dart';
import 'package:wigilabs_app/services/singIn_service.dart';
import 'package:wigilabs_app/widgets/widgets.dart';

class LoginPage extends StatelessWidget {
 
  final SingInService singInService = SingInService();
  
  @override
  Widget build(BuildContext context) {
    final size  =  MediaQuery.of(context).size;
    //print(this.singInService.user?.uid);
    
    
    return this.singInService.user?.uid != null?HomePage():signInPageWidget(size,context);
  }

  Scaffold signInPageWidget(Size size, BuildContext context) {
    return Scaffold(
     body:SingleChildScrollView(
     child: Column(
       children: [
         
         titleApp(size),
         signInTitle(size),
         inputUser(size),
         inputPassword(size),
         singInButtonMail(size),
         singInButtonOtherAccounts(size,true,context),
         singInButtonOtherAccounts(size,false,context),
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
         child: TextoCustomedWidget(text:'WigiLabs Test App',size: 40.0, color:Colors.black,font: FontWeight.w100),
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

  Widget singInButtonOtherAccounts(Size size, bool isLogginFacebook, BuildContext context){
    return GestureDetector(
      onTap: ()async{
        
        final User? isAuth =  isLogginFacebook?await signInFb(): await signInGoogle();
        print('mm');
        //print(isAuth!.uid);
        if (isAuth!.uid != null){
          Navigator.pushNamed(context, 'home');
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
}