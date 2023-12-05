
import 'package:apps/data_network_coller/model_api/newtask.dart';
import 'package:apps/data_network_coller/model_api/taskcountsummarymodel.dart';
import 'package:apps/data_network_coller/network_coller.dart';
import 'package:apps/data_network_coller/network_responce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data_network_coller/data_utility/urls.dart';
import '../widget/profile_summary.dart';
import '../widget/summary_card.dart';
import '../widget/task_card.dart';

class Progressscreen extends StatefulWidget {
  const Progressscreen({super.key});

  @override
  State<Progressscreen> createState() => _ProgressscreenState();
}

class _ProgressscreenState extends State<Progressscreen> {
bool inprogrebool=false;
  bool inprosummary=false;
  Newtask newtask=Newtask();
  Taskcountsummarymodel taskcountsummarymodel=Taskcountsummarymodel();

Future<void>getinprogress()async{
  inprogrebool =true;
  if(mounted){
    setState(() {

    });
  }
  final Networkresponce networkresponce =await Networkcoller().getrequest(Urls.improgressScreen);
if(networkresponce.isSuccess){

newtask =Newtask.fromJson(networkresponce.jsonresponce);
}

inprogrebool=false;
if(mounted){
  setState(() {

  });
}
}

Future<void>countinprosummary()async{
  inprosummary =true;
  if(mounted){
    setState(() {

    });
  }
  final Networkresponce networkresponce =await Networkcoller().getrequest(Urls.gettasksummary);
  if(networkresponce.isSuccess){
    taskcountsummarymodel=Taskcountsummarymodel.fromJson(networkresponce.jsonresponce);
  }
  inprosummary =false;
  if(mounted){
    setState(() {

    });
  }
}
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    countinprosummary();
    getinprogress();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Profilesummary(),
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Row(
            //     children: [
            //
            //       Summarycard(count: "9", summary: "New"),
            //       Summarycard(count: "9", summary: "in Progress"),
            //       Summarycard(count: "9", summary: "Completed"),
            //       Summarycard(count: "9", summary: "Cancelled")
            //     ],
            //   ),
            // ),

            Visibility(
              visible: inprosummary==false,
              replacement: Center(child: CircularProgressIndicator()),
              child: SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                    itemCount: taskcountsummarymodel.data?.length??0,
                    itemBuilder: (context,index){
Taskcount taskcount=taskcountsummarymodel.data![index];
                  return   Summarycard(
                      count: taskcount.sum.toString(),
                      summary: taskcountsummarymodel.data![index].id.toString()
                  );
                }),
              ),
            ),
            Expanded(
              child: Visibility(
                visible: inprogrebool==false,
                replacement: Center(child: CircularProgressIndicator()),
                child: RefreshIndicator(
                  onRefresh: getinprogress,
                  child: ListView.builder(
                      itemCount: newtask.data?.length??0,
                      itemBuilder: (context,index){
                      return
                        Taskcard(

                        task:newtask.data![index] ,
                        onstatuschange: () {
                          getinprogress();
                        },
                        showprogress: (Inprogress) {
                          inprogrebool=Inprogress;
                          if(mounted){
                            setState(() {

                            });
                          }
                        },

                      );
                      }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


}
