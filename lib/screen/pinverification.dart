

import 'package:apps/controller/auth_controller.dart';
import 'package:apps/screen/resetpassword.dart';
import 'package:apps/widget/background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../data_network_coller/data_utility/urls.dart';
import '../data_network_coller/model_api/usermodel.dart';
import '../data_network_coller/network_coller.dart';
import '../data_network_coller/network_responce.dart';
import '../widget/snack_messege.dart';

class Pinverification extends StatefulWidget {
  String email;
   Pinverification({super.key,required this.email });

  @override
  State<Pinverification> createState() => _PinverificationState();
}

class _PinverificationState extends State<Pinverification> {
TextEditingController _getotp=TextEditingController();
  bool getotpp=false;

  Future<void> getotpform(String otp) async {

    getotpp=true;
    if(mounted){
      setState(() {

      });
    }
    final Networkresponce networkresponce =
    await Networkcoller().getrequest(Urls.otpfrom(
        widget.email.toString(),
        otp));
    print(Urls.otpfrom(widget.email.toString(),otp));
    getotpp=false;
    if(mounted){
      setState(() {

      });
    }
    if (networkresponce.isSuccess && networkresponce.jsonresponce["status"]=="success") {
      //await Authcontroller.writeEmailverified(networkresponce.jsonresponce["email"]);
      if (mounted) {
        SnackMessege(context, "OTP success");
      }

      if (mounted) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Resetpasswordscreen
            (email: widget.email.toString(),
            Otp: _getotp.text.toString(),);
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
        child:SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(height: 80,),
            Text("Pin Varification",style: Theme.of(context).textTheme.titleLarge,),
                SizedBox(height: 20,),
                Text("A 6 digit OTP sent your enail"),
                SizedBox(height: 48,),
                PinCodeTextField(
controller: _getotp,
                  appContext: context,
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                    activeColor: Colors.green,
                    selectedFillColor: Colors.white,
                    inactiveFillColor: Colors.white
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Colors.blue.shade50,
                  enableActiveFill: true,


                  onCompleted: (v) {
                    print("Completed");
                  },
                  onChanged: (value) {
                    print(value);

                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    return true;
                  },
                ),
                SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible:getotpp==false ,
                      replacement:Center(child: CircularProgressIndicator()) ,
                      child: ElevatedButton(onPressed: (){
                      getotpform(
                         _getotp.text.toString()
                      ) ;
                      }, child: Text("Verified")),
                    )),
SizedBox(height: 48,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Have an account",style: TextStyle(fontSize: 16,color: Colors.black54),),
                    TextButton(onPressed: (){}, child:Text("Sign in"))
                  ],
                )
            ],),
          ),
        ),
      ),
    );
  }
}

