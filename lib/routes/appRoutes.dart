

import 'package:flutter/material.dart';
import 'package:wigilabs_app/pages/artist_Page.dart';
import 'package:wigilabs_app/pages/home_Page.dart';
import 'package:wigilabs_app/pages/playList_Page.dart';
import 'package:wigilabs_app/pages/signIn_Page.dart';
import 'package:wigilabs_app/pages/signUp_Page.dart';
import 'package:wigilabs_app/pages/songs_page.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
  'loggin'    : ( _ )=> LoginPage(),
  'home'      : ( _ )=> HomePage(),
  'playList'  : ( _ )=> PlayListPage(),
  'songs'     : ( _ )=> SongsPage(),
  'artist'    : ( _ )=> ArtistPage(),
  'signUp'    : ( _ )=> SignUpPage(),
};