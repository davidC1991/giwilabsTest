

import 'package:flutter/material.dart';
import 'package:wigilabs_app/pages/home_Page.dart';
import 'package:wigilabs_app/pages/signIn_Page.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
  'login' : ( _ )=> LoginPage(),
  'home'  : ( _ )=> HomePage(),
};