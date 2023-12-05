import 'dart:convert';

import 'package:apps/controller/auth_controller.dart';
import 'package:apps/data_network_coller/data_utility/urls.dart';
import 'package:apps/data_network_coller/model_api/usermodel.dart';
import 'package:apps/data_network_coller/network_coller.dart';
import 'package:apps/data_network_coller/network_responce.dart';
import 'package:apps/screen/forgot_password.dart';
import 'package:apps/screen/main_button_nav_screen.dart';
import 'package:apps/screen/sign%20up.dart';
import 'package:apps/widget/background.dart';
import 'package:apps/widget/snack_messege.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  TextEditingController _emailtext = TextEditingController();
  TextEditingController _passwordtext = TextEditingController();
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool _loginprogress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Backgroundimage(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Form(
              key: _globalKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Text("Get Started with",
                      style: Theme.of(context).textTheme.titleLarge),
                  TextFormField(
                    controller: _emailtext,
                    decoration: const InputDecoration(
                      hintText: "Email",
                    ),
                    // validator: (String?value){
                    //   if(value?.trim().isEmpty?? true){
                    //     return "Enter value";
                    //   }
                    //   else{
                    //     return null;
                    //   }
                    // }
                    validator: (String? valu) {
                      if (valu?.trim().isEmpty ?? true) {
                        return 'Enter valid number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _passwordtext,
                    decoration: const InputDecoration(
                      hintText: "Password",
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter value";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: _loginprogress == false,
                        replacement:
                            Center(child: CupertinoActivityIndicator()),
                        child: ElevatedButton(
                            onPressed: () {
                              login();
                            },
                            child: Icon(Icons.arrow_circle_right)),
                      )),
                  SizedBox(
                    height: 48,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Forgotpasswordscreen();
                        }));
                      },
                      child: const Text(
                        "Forget password",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Dont have an account?",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Signupscreen();
                            }));
                          },
                          child: Text(
                            "Sign up",
                            style: TextStyle(fontSize: 16),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  Future<void> login() async {
    if (!_globalKey.currentState!.validate()) {
      return;
    }
    _loginprogress = true;
    if (mounted) {
      setState(() {});
    }
    Networkresponce responce = await Networkcoller().Postrequest(Urls.login,
        body: {
          "email": _emailtext.text.trim(),
          "password": _passwordtext.text,
        },
        islogin: true);

    _loginprogress = false;
    if (mounted) {
      setState(() {});
    }
    if (responce.isSuccess) {
      await Authcontroller.saveuserinformation(responce.jsonresponce["token"],
          Data.fromJson(responce.jsonresponce["data"]));

      if (mounted) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Mainbuttonnavscreen();
        }));
      }
    } else {
      if (responce.statuscode == 401) {
        if (mounted) {
          SnackMessege(context, "Plesase enter correct email or pass");
        }
      } else {
        if (mounted) {
          SnackMessege(context, "Login faild try agein");
        }
      }
    }
  }

  @override
  void dispose() {
    _passwordtext.dispose();
    _emailtext.dispose();
    super.dispose();
  }
}
