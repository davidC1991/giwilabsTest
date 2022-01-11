import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {

  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  late SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();

     
  }
    
   get isUserOK {
    return _prefs.getString('key') ?? '';
  }
   get nameAuthSocialNetwork{
    return _prefs.getString('namFb') ?? '';
  }
   
   get mailAuthSocialNetwork{
    return _prefs.getString('mailA') ?? '';
  }
   get nameAuthWigilab {
    return _prefs.getString('namA') ?? '';
  }
   get surnameAuthWigilab {
    return _prefs.getString('surA') ?? '';
  }
   get mailAuthWigilab {
    return _prefs.getString('maiWi') ?? '';
  }
   get idAuthWigilab {
    return _prefs.getString('idWi') ?? '';
  }


  set setUser( String value ) {
    _prefs.setString('key', value);
  }
  set setNameAuthSocialNetwork( String value ) {
    _prefs.setString('namFb', value);
  }
  set setMailAuthSocialNetwork( String value ) {
    _prefs.setString('mailA', value);
  }
  set setNameAuthWigilab( String value ) {
    _prefs.setString('namA', value);
  }
  set setMailAuthWigilab( String value ) {
    _prefs.setString('maiWi', value);
  }
  set setIdAuthWigilab( String value ) {
    _prefs.setString('idWi', value);
  }
  set setsurnameAuthWigilab( String value ) {
    _prefs.setString('surA', value);
  }
  

 

}
