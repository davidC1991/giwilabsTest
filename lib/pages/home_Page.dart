import 'package:flutter/material.dart';
import 'package:wigilabs_app/services/singIn_service.dart';

class HomePage extends StatelessWidget {
  final SingInService singInService = SingInService();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: ()=> singInService.signOutFb(),
        child: Center(child: Text('Home Page'),)),    
    );
  }
}
 
