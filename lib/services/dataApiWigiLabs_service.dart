import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:wigilabs_app/models/apiWigiLab_model.dart';

class DataUserWigiLab{
  final String name = '';
  final String surname = '';
  final String mail = '';
  final int id = 0;

  //DataUserWigiLab({required this.name, required this.surname, required this.mail, required this.id});

  Future<Usuario?>getDataFromApiWigiLabs() async {
    
    final authData = {
      'data': {  
        'nombreUsuario' : 'odraude1362@gmail.com',
        'clave'         : 'Jorgito123',
        }
      };

    final headers = {
      'Content-Type' : 'application/json',
      'X-MC-SO'      : 'WigilabsTest'
    };

    var url_2 = Uri.parse('https://apim3w.com/api/index.php/v1/soap/LoginUsuario.json');

    final resp = await http.post(
        url_2,
        headers: headers,
        body: json.encode(authData)
    );
    
    final responseApiWigiLab = ResponseApiWigiLab.fromJson(resp.body);
    if (responseApiWigiLab.error == 0){
      print(responseApiWigiLab.response!.usuario!.documentNumber!);
      return responseApiWigiLab.response!.usuario!;
    }

    return null;
  }
}