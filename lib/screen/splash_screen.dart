
import 'package:apps/controller/auth_controller.dart';
import 'package:apps/screen/login_screen.dart';
import 'package:apps/screen/main_button_nav_screen.dart';
import 'package:apps/widget/background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    gotoLogin();
  }

Future< void> gotoLogin()async{
final bool isloogin= await Authcontroller.cheekAuth();
  Future.delayed(Duration(seconds: 3)).then((value) =>
  Navigator.push(context as BuildContext,MaterialPageRoute(builder: (context)=>
    isloogin?
    Mainbuttonnavscreen() : Loginscreen(),
  ))
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
                   // SvgPicture.asset("assets/images/background.svg",height:double.infinity,width: double.infinity,fit: BoxFit.cover,),
                   Backgroundimage(child:Center(
                   child: SvgPicture.asset("assets/images/logo.svg",
                   width: 120,fit: BoxFit.cover,)) ,),
        ],
      ),
    );
  }
}
