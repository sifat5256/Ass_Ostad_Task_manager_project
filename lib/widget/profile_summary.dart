
import 'dart:convert';

import 'package:apps/controller/auth_controller.dart';
import 'package:apps/screen/login_screen.dart';
import 'package:apps/screen2/edit_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Profilesummary extends StatelessWidget {
  Profilesummary({super.key,  this.enabletap=true});
  final bool enabletap;

  @override
  Widget build(BuildContext context) {
    Uint8List imageByte =Base64Decoder().convert(Authcontroller.user?.photo??"");

    return  ListTile(
      onTap: (){
        if(enabletap) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Editprofilescreen();
          }));
        }},
      leading: CircleAvatar(
        child: Authcontroller.user?.photo==null? Icon(Icons.person):
        Image.memory(imageByte),
      ),
      title: Text(fullname),
      subtitle: Text(Authcontroller.user?.email??''),
      trailing: IconButton(
        onPressed: ()async{
          await Authcontroller.clearAuth();
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Loginscreen()), (route) => false);

        }, icon:Icon( Icons.logout),
      ),
      tileColor: Colors.green,
    );
  }
  String get fullname{
return ("${Authcontroller.user?.firstName??""} ${Authcontroller.user?.lastName??""}");
  }
}
