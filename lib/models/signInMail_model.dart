// To parse this JSON data, do
//
//     final responseSingInMail = responseSingInMailFromMap(jsonString);

import 'dart:convert';

class ResponseSingInMail {
    ResponseSingInMail({
        this.kind,
        this.localId,
        this.email,
        this.displayName,
        this.idToken,
        this.error,
    });

    String? kind;
    String? localId;
    String? email;
    String? displayName;
    String? idToken;
    ResponseSingInMailError? error;

    factory ResponseSingInMail.fromJson(String str) => ResponseSingInMail.fromMap(json.decode(str));
    factory ResponseSingInMail.fromJson2(String str) => ResponseSingInMail.fromMap2(json.decode(str));

  

    factory ResponseSingInMail.fromMap(Map<String, dynamic> json) => ResponseSingInMail(
        kind: json["kind"],
        localId: json["localId"],
        email: json["email"],
        displayName: json["displayName"],
        idToken: json["idToken"],
    );

    factory ResponseSingInMail.fromMap2(Map<String, dynamic> json) => ResponseSingInMail(
        error: ResponseSingInMailError.fromMap(json["error"]),
      
    );

   
}

class ResponseSingInMailError {
    ResponseSingInMailError({
        this.code,
        this.message,
        this.errors,
    });

    int? code;
    String? message;
    List<ErrorElement>? errors;

    factory ResponseSingInMailError.fromJson(String str) => ResponseSingInMailError.fromMap(json.decode(str));

    

    factory ResponseSingInMailError.fromMap(Map<String, dynamic> json) => ResponseSingInMailError(
        code: json["code"],
        message: json["message"],
        errors: List<ErrorElement>.from(json["errors"].map((x) => ErrorElement.fromMap(x))),
    );

    
}

class ErrorElement {
    ErrorElement({
        this.message,
        this.domain,
        this.reason,
    });

    String? message;
    String? domain;
    String? reason;

    factory ErrorElement.fromJson(String str) => ErrorElement.fromMap(json.decode(str));

 

    factory ErrorElement.fromMap(Map<String, dynamic> json) => ErrorElement(
        message: json["message"],
        domain: json["domain"],
        reason: json["reason"],
    );

   
}

// import 'dart:convert';

// class ResponseSingInMail {
//     ResponseSingInMail({
//         this.kind,
//         this.localId,
//         this.email,
//         this.displayName,
//         this.idToken,
//     });

//     String? kind;
//     String? localId;
//     String? email;
//     String? displayName;
//     String? idToken;

//     factory ResponseSingInMail.fromJson(String str) => ResponseSingInMail.fromMap(json.decode(str));

   

//     factory ResponseSingInMail.fromMap(Map<String, dynamic> json) => ResponseSingInMail(
//         kind: json["kind"],
//         localId: json["localId"],
//         email: json["email"],
//         displayName: json["displayName"],
//         idToken: json["idToken"],
//     );

// }
