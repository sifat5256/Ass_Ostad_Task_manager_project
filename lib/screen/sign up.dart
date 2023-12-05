
import 'package:apps/data_network_coller/data_utility/urls.dart';
import 'package:apps/data_network_coller/network_coller.dart';
import 'package:apps/data_network_coller/network_responce.dart';
import 'package:apps/screen/login_screen.dart';
import 'package:apps/widget/background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widget/snack_messege.dart';
class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  final TextEditingController _emailtext =TextEditingController();
  final TextEditingController _fastnametext=TextEditingController();
  final TextEditingController _lastnametext=TextEditingController();
  final TextEditingController _mobiletext=TextEditingController();
  final TextEditingController _passtext =TextEditingController();
final GlobalKey<FormState>_formkey=GlobalKey<FormState>();
  bool _signupinprogress=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Backgroundimage(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key:_formkey ,
              child: Column(
                children: [
                  SizedBox(height: 80,),
                  Text("Join with us",style: Theme.of(context).textTheme.titleLarge,),
                  TextFormField(
                    controller: _emailtext,
                    decoration: InputDecoration(
                        hintText: "Email"
                    ),
                    validator: (String?valu){
                      if(valu?.trim().isEmpty??true){
                        return 'Enter valid number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16,),
                  TextFormField(
                    controller: _fastnametext,
                    decoration: InputDecoration(
                      hintText: 'Fast name',
                    ),
                    validator: (String?valu){
                      if(valu?.trim().isEmpty??true){
                        return 'Enter valid number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16,),
                  TextFormField(
                    controller: _lastnametext,
                    decoration: InputDecoration(
                        hintText: "Last name"
                    ),
                    validator: (String?valu){
                      if(valu?.trim().isEmpty??true){
                        return 'Enter valid number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16,),
                  TextFormField(
                    controller: _mobiletext,
                    decoration: InputDecoration(
                        hintText: "Mobile"
                    ),
                    validator: (String?valu){
                      if(valu?.trim().isEmpty??true){
                        return 'Enter valid number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16,),
                  TextFormField(
                    controller:_passtext ,
                    decoration: InputDecoration(
                        hintText: "Password"
                    ),
                    validator: (String?valu){
                      if(valu?.isEmpty??true){
                        return 'Enter valid number';
                      }
                      if(valu!.length<6){
                        return 'Valu more then 6';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 48,),
                  SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: _signupinprogress==false,
                        replacement: Center(child: CupertinoActivityIndicator()),
                        child: ElevatedButton(onPressed: (){
                          signup();
                        }
                      , child: Icon(Icons.arrow_circle_right)),
                      )),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("You have already account?",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.black54),),
                      TextButton(onPressed: (){

                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return Loginscreen();
                        }));
                      }, child: Text("Sign in"))
                    ],
                  )
                ],
              ),
            ),
          ),
        ) ,
      )
    );
  }

  Future<void>signup()  async{
    if(_formkey.currentState!.validate()){
      _signupinprogress=true;
      if(mounted){
        setState(() {

        });
      }
      final Networkresponce responce=await Networkcoller().Postrequest(
          Urls.registation,body: {
        "email":_emailtext.text.toString(),
        "firstName":_fastnametext.text.toString(),
        "lastName":_lastnametext.text.toString(),
        "mobile":_mobiletext.text.toString(),
        "password":_passtext.text.toString(),
        "photo":""
      });
      _signupinprogress=false;
      if(mounted){
        setState(() {
        });
      }
      if(responce.isSuccess){
        _clratmethod();
        if(mounted){
          SnackMessege(context, 'Account has been creat');
        }
      }
      else{
        if(mounted){
          SnackMessege(context, "Account has not creat",true);
        }
      }
    }

  }
  void _clratmethod(){
    _passtext.clear();
    _mobiletext.clear();
    _lastnametext.clear();
    _emailtext.clear();
    _fastnametext.clear();
  }

  @override
  void dispose() {
    _passtext.dispose();
    _mobiletext.dispose();
    _lastnametext.dispose();
    _emailtext.dispose();
    _fastnametext.dispose();
    super.dispose();
  }
}
