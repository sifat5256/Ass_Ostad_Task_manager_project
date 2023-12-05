import 'package:apps/controller/auth_controller.dart';
import 'package:apps/data_network_coller/data_utility/urls.dart';
import 'package:apps/data_network_coller/model_api/usermodel.dart';
import 'package:apps/data_network_coller/network_coller.dart';
import 'package:apps/data_network_coller/network_responce.dart';
import 'package:apps/screen/pinverification.dart';
import 'package:apps/widget/background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data_network_coller/model_api/newtask.dart';
import '../widget/snack_messege.dart';

class Forgotpasswordscreen extends StatefulWidget {
  Forgotpasswordscreen({super.key});



  @override
  State<Forgotpasswordscreen> createState() => _ForgotpasswordscreenState();
}

class _ForgotpasswordscreenState extends State<Forgotpasswordscreen> {
  final TextEditingController _emailtext=TextEditingController();
  bool getemail=false;

  Future<void> getemailotp(String email) async {

    getemail=true;
    if(mounted){
      setState(() {

      });
    }
    final Networkresponce networkresponce =
    await Networkcoller().getrequest(Urls.emailotp(email));
    print(Urls.emailotp(email));
    getemail=false;
    if(mounted){
      setState(() {

      });
    }
    if (networkresponce.isSuccess) {
      //await Authcontroller.writeEmailverified(networkresponce.jsonresponce["email"]);
      if (mounted) {
        SnackMessege(context, "OTP Send success");
      }

      if (mounted) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Pinverification(email: _emailtext.text.toString(),);
        }));
      }
    } else {
      if (mounted) {
        SnackMessege(context, "OTP Failed");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Backgroundimage(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 80,
                ),
                Text(
                  "Your Email adress",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text("A 6 digit OTP will be sent your email"),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _emailtext,
                  decoration: InputDecoration(hintText: "Email"),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: double.infinity,
                    child: Visibility(

                      visible: getemail==false,
                      replacement: Center(child: CircularProgressIndicator()),
                      child: ElevatedButton(
                          onPressed: () {
                            getemailotp(_emailtext.text.toString());
                          },
                          child: Icon(Icons.arrow_circle_right)),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Have account?",
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    TextButton(onPressed: () {}, child: Text("Sign in"))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
