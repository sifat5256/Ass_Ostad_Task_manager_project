
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

class Cencelledscreen extends StatefulWidget {
  const Cencelledscreen({super.key});

  @override
  State<Cencelledscreen> createState() => _CencelledscreenState();
}

class _CencelledscreenState extends State<Cencelledscreen> {

  bool getcancel =false;
  bool getsum=false;
Newtask newtask=Newtask();
  Taskcountsummarymodel taskcountsummarymodel =Taskcountsummarymodel();

Future<void>getcancellde()async{
  getcancel =true;
  if(mounted){
    setState(() {

    });
  }
  final Networkresponce networkresponce=await Networkcoller().getrequest(Urls.cancellscreen);
  if(networkresponce.isSuccess){
newtask=Newtask.fromJson(networkresponce.jsonresponce);
  }
  getcancel =false;
  if(mounted){
    setState(() {

    });
  }

}

  Future<void>getcancellsum()async{
    getsum =true;
    if(mounted){
      setState(() {

      });
    }
    final Networkresponce networkresponce=await Networkcoller().getrequest(Urls.gettasksummary);
    if(networkresponce.isSuccess){
taskcountsummarymodel=Taskcountsummarymodel.fromJson(networkresponce.jsonresponce);
    }
    getsum =false;
    if(mounted){
      setState(() {
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcancellde();
    getcancellsum();
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
            //       Summarycard(count: "9", summary: "in progress"),
            //       Summarycard(count: "9", summary: "Completed"),
            //       Summarycard(count: "9", summary: "Cancelled")
            //     ],
            //   ),
            // ),

            Visibility(
              visible: getsum==false,
              replacement: Center(child: CircularProgressIndicator()),
              child: SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                    itemCount: taskcountsummarymodel.data?.length??0,
                    itemBuilder: (context,index){
                      Taskcount taskcoun=taskcountsummarymodel.data![index];
                  return   Summarycard(
                      count: taskcoun.sum.toString(),
                      summary: taskcountsummarymodel.data![index].id.toString()
                  );
                }),
              ),
            ),


            Expanded(
              child: Visibility(
                visible: getcancel==false,
                replacement: Center(child: CircularProgressIndicator()),
                child: RefreshIndicator(
                  onRefresh: getcancellde,
                  child: ListView.builder(
                      itemCount: newtask.data?.length??0,
                      itemBuilder: (context,index){
                       return Taskcard(
                         task: newtask.data![index],
                         onstatuschange: () {
                           getcancellde();
                         },
                         showprogress: (Inprogress ) {
                           getcancel=Inprogress;
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
