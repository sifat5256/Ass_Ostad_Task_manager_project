import 'dart:convert';

import 'package:apps/data_network_coller/model_api/usermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authcontroller{
 static String ? token;
 static Data ?user;
static  Future<void> saveuserinformation(String t,Data model)async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    await sharedPreferences.setString("token",t);
    await sharedPreferences.setString("user",jsonEncode( model.toJson()));
    token=t;
    user=model;
  }

 static  Future<void> upgradeinformation(Data model)async{
   SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
   await sharedPreferences.setString("user",jsonEncode( model.toJson()));
   user=model;
 }


static Future<void>initializeduser()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
   token= sharedPreferences.getString("token");
   user= Data.fromJson(jsonDecode(sharedPreferences.getString("user")??"{}"));
}

static Future<bool>cheekAuth()async{
  SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  String? token= sharedPreferences.getString("token");
  if(token!=null){
    await initializeduser();
    return true;
  }
  else{
    return false;
  }
}
static Future<void> clearAuth()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    await sharedPreferences.clear();

}

static Future<void>writeEmailverified()async{
  final SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
  await sharedPreferences.getString("email");
}


}