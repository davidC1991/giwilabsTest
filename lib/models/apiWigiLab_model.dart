// To parse this JSON data, do
//
//     final responseApiWigiLab = responseApiWigiLabFromMap(jsonString);

import 'dart:convert';

class ResponseApiWigiLab {
    ResponseApiWigiLab({
        this.error,
        this.response,
        this.srvNodo,
        this.secs,
        this.responseApiWigiLabServer,
        this.reqXml,
        this.resServer,
        this.url,
    });

    int? error;
    Response? response;
    String? srvNodo;
    String? secs;
    String? responseApiWigiLabServer;
    String? reqXml;
    String? resServer;
    String? url;

    factory ResponseApiWigiLab.fromJson(String str) => ResponseApiWigiLab.fromMap(json.decode(str));
   
      
    factory ResponseApiWigiLab.fromMap(Map<String, dynamic> json) => ResponseApiWigiLab(
        error: json["error"],
        response: Response.fromMap(json["response"]),
        srvNodo: json["srv_nodo"],
        secs: json["secs"],
        responseApiWigiLabServer: json["server"],
        reqXml: json["reqXML"],
        resServer: json["resServer"],
        url: json["url"],
    );

}
        
       
class Response {
    Response({
        this.usuario,
       
    });

    Usuario? usuario;
    

    factory Response.fromJson(String str) => Response.fromMap(json.decode(str));

    

    factory Response.fromMap(Map<String, dynamic> json) => Response(
        usuario: Usuario.fromMap(json["usuario"]),
        
    );

}
    
class Usuario {
    Usuario({
        this.nombre,
        this.apellido,
        this.userProfileId,
        this.documentNumber,
        this.documentType,
        this.claveTemporal,
        this.esUsuarioInspira,
        this.esSolicitarRegistro,
        this.esCambioNombreUsuario,
        this.roleId,
        this.tipoClienteId,
        this.tipoUsuarioId,
        this.tokenSso,
        this.uid,
    });

    String? nombre;
    String? apellido;
    String? userProfileId;
    String? documentNumber;
    String? documentType;
    int? claveTemporal;
    int? esUsuarioInspira;
    int? esSolicitarRegistro;
    int? esCambioNombreUsuario;
    String? roleId;
    String? tipoClienteId;
    String? tipoUsuarioId;
    String? tokenSso;
    String? uid;

    factory Usuario.fromJson(String str) => Usuario.fromMap(json.decode(str));

    

    factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
        nombre: json["nombre"],
        apellido: json["apellido"],
        userProfileId: json["UserProfileID"],
        documentNumber: json["DocumentNumber"],
        documentType: json["DocumentType"],
        claveTemporal: json["claveTemporal"],
        esUsuarioInspira: json["esUsuarioInspira"],
        esSolicitarRegistro: json["esSolicitarRegistro"],
        esCambioNombreUsuario: json["esCambioNombreUsuario"],
        roleId: json["roleID"],
        tipoClienteId: json["tipoClienteID"],
        tipoUsuarioId: json["tipoUsuarioID"],
        tokenSso: json["tokenSSO"],
        uid: json["UID"],
    );

    
}


      
 

  



    




