
import 'package:apps/data_network_coller/data_utility/urls.dart';
import 'package:apps/data_network_coller/network_coller.dart';
import 'package:apps/data_network_coller/network_responce.dart';
import 'package:apps/widget/profile_summary.dart';
import 'package:apps/widget/snack_messege.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Addnewtask extends StatefulWidget {
  const Addnewtask({super.key});

  @override
  State<Addnewtask> createState() => _AddnewtaskState();

}
class _AddnewtaskState extends State<Addnewtask> {
  TextEditingController _subjectText =TextEditingController();
  TextEditingController _discriptText =TextEditingController();
  GlobalKey<FormState> _formkey=GlobalKey<FormState>();
  bool _controllers=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Profilesummary(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 80,),

                  Text("Add New Task",style: Theme.of(context).textTheme.titleLarge,),
                  TextFormField(
                    controller: _subjectText,
                    decoration: InputDecoration(
                      hintText: "subject"
                    ),
                    validator: (String?value){
                      if(value?.trim().isEmpty??true){
                        return "Enter value";
                      }
                      else{
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: _discriptText,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: "Description",
                    ),
                    validator: (String?value){
                      if(value?.trim().isEmpty??true){
                        return "Enter value";
                      }
                      else{
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 30,),
                  SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: _controllers==false,
                        replacement: Center(child: CircularProgressIndicator()),
                        child: ElevatedButton(
                            onPressed: creatTasks,
                            child: Icon(Icons.arrow_circle_right_rounded)),
                      ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> creatTasks()async {
  if(_formkey.currentState!.validate()){
    _controllers=true;
    if(mounted){
      setState(() {

      });
    }
  final Networkresponce responcer= await Networkcoller().Postrequest(Urls.creatnewtask,
      body: {
        "title":_subjectText.text.trim(),
        "description":_discriptText.text.trim(),
        "status":"New"
  });
    _controllers=false;
    if(mounted){
      setState(() {

      });
    }

    if(responcer.isSuccess){
      _discriptText.clear();
      _subjectText.clear();
      if(mounted){
        SnackMessege(context," new task add");
      }

    }
    else{
      if(mounted){
        SnackMessege(context,"Creat new task faild try again",true);
      }
    }
  }
  }


  @override
  void dispose() {
    _discriptText.dispose();
    _subjectText.dispose();
    super.dispose();
  }
}
