

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wigilabs_app/bloc/user/user_bloc.dart';
import 'package:wigilabs_app/helpers/alertasRapidas.dart';
import 'package:wigilabs_app/services/singIn_service.dart';
import 'package:wigilabs_app/widgets/texto.dart';

class SignUpPage extends StatelessWidget {
 
  final SingInService singInService = SingInService();
  final TextEditingController emailController    = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKeyEmail = GlobalKey<FormState>();
  final formKeyPassword = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final UserBloc userBloc = BlocProvider.of<UserBloc>(context, listen: true);
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              children: [
                titleApp(size),
                formAux(formKeyEmail, userBloc, emailController, isMail:true),
                formAux(formKeyPassword, userBloc, passwordController, isMail:false),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  width: size.width * 0.45,
                  child: Row(
                    children: [
                      buttonRegister(userBloc, context),
                      SizedBox(width: 10,),
                      buttonSignIn(userBloc, context)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

   buttonSignIn(UserBloc userBloc, BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pushReplacementNamed(context, 'loggin'),
      child: Text('Sign In')
    );
  }

  ElevatedButton buttonRegister(UserBloc userBloc, BuildContext context) {
    return ElevatedButton(
      onPressed: ()async{
        if(userBloc.state.email!= null && userBloc.state.password != null){
            Map<String, dynamic> resp = await singInService.singUpFirebaseMail(userBloc.state.email!, userBloc.state.password!);
            if (resp['ok']){
               emailController.clear();
               passwordController.clear();
               userBloc.add(UserRegisteredEmail(true));
               formKeyEmail.currentState?.validate();
               FocusScope.of(context).unfocus();
               mensajePantalla('Successful Registration');
            }else{
               FocusScope.of(context).unfocus();
               mensajePantalla(resp['message']);
            }
        }
      },
      child: Text('Register')
    );
  }

 Widget formAux(GlobalKey<FormState> formKey, UserBloc userBloc, TextEditingController controller, {bool isMail = true} ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
            key: formKey,
            controller: controller, 
            autofocus: false,
            obscureText: isMail?false:true,
            onChanged: (value){
              if(isMail) userBloc.add(SignUPWithEmail(email: value));
              if(!isMail) userBloc.add(SignUPWithEmail(password: value));
              
            },
            validator: ( value ){
              if ( value == null ) return 'this field is required';
              return value.length < 3 ? ' Unless three characters' : null;
            },
            autovalidateMode: userBloc.state.isRegisteredEmail!?AutovalidateMode.disabled: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
               hintText: isMail?'Mail or User Name':'Password',
               labelText:isMail?'User Name':'Password',
               border: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  )
             )
            )
          ),
    );
  }

  Container titleApp(Size size) {
    return Container(
      padding: EdgeInsets.only(top: size.height * 0.2),
         alignment: Alignment.topCenter,
         margin: EdgeInsets.only(bottom: size.height * 0.04),
         width: size.width * 1,
         height: size.height * 0.3,
         child: TextoCustomedWidget(text:'WigiLabs Test App',size: 40.0, color:Colors.white,font: FontWeight.w100),
       );
  }
}
    
    