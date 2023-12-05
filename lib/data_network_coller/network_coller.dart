import 'dart:convert';

import 'package:apps/controller/auth_controller.dart';
import 'package:apps/main.dart';
import 'package:apps/screen/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'network_responce.dart';
class Networkcoller{
  Future<Networkresponce>Postrequest(String uri,
      {Map<String,dynamic>?body,bool islogin=false})async{
  try{
 final   Response response =await post(Uri.parse(uri),body: jsonEncode(body),headers: {
      "Content-Type":"application/json",
    "token":Authcontroller.token.toString(),
    });
 //log(response.statusCode.toString());
 print(response.statusCode.toString());
 print(response.headers.toString());

 if(response.statusCode==200){
   return Networkresponce(
     isSuccess: true,
   statuscode: 200,
     jsonresponce: jsonDecode(response.body)
   );
 }
 else if(response.statusCode==401){
   if(islogin==false){
     backlogin() ;
   }

   return Networkresponce(
       isSuccess: false,
       statuscode: response.statusCode,
       jsonresponce: jsonDecode(response.body)
   );
 }
 else{
   return Networkresponce(
     isSuccess: false,
   statuscode: response.statusCode,
     jsonresponce: jsonDecode(response.body)
   );
 }
  }
  catch (e){
return Networkresponce(
  isSuccess: false,
 errortext: e.toString()
);
  }
  }



  Future<Networkresponce>getrequest(String uri)async{
    try{
      final   Response response =await get(Uri.parse(uri),headers: {
        "Content-Type":"application/json",
        "token":Authcontroller.token.toString(),
      });
      print(response.statusCode.toString());
      print(response.headers.toString());

      if(response.statusCode==200){
        return Networkresponce(
            isSuccess: true,
            statuscode: 200,
            jsonresponce: jsonDecode(response.body)
        );
      }
      else if(response.statusCode==401){
          backlogin() ;

        return Networkresponce(
            isSuccess: false,
            statuscode: response.statusCode,
            jsonresponce: jsonDecode(response.body)
        );
      }
      else{
        return Networkresponce(
            isSuccess: false,
            statuscode: response.statusCode,
            jsonresponce: jsonDecode(response.body)
        );
      }
    }
    catch (e){
      return Networkresponce(
          isSuccess: false,
          errortext: e.toString()
      );
    }
  }



 Future<void>  backlogin()async{
    await Authcontroller.clearAuth();
    Navigator.pushAndRemoveUntil(
        Myapps.navigatorkey.currentContext!,
        MaterialPageRoute(builder: (context){
          return Loginscreen();
        }), (route) => false);
  }
}