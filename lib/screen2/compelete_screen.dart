
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

class Compeletescreen extends StatefulWidget {
  const Compeletescreen({super.key});

  @override
  State<Compeletescreen> createState() => _CompeletescreenState();
}

class _CompeletescreenState extends State<Compeletescreen> {
bool completeinpro=false;
bool completsummarys=false;

Newtask newtask =Newtask();
Taskcountsummarymodel taskcountsummarymodel=Taskcountsummarymodel();

  Future<void>getcompleted()async{
    completeinpro=true;
    if(mounted){
      setState(() {

      });
    }
    final Networkresponce networkresponce =await Networkcoller().getrequest(Urls.completedscreen);
    if(networkresponce.isSuccess){
newtask=Newtask.fromJson(networkresponce.jsonresponce);
    }
    completeinpro=false;
    if(mounted){
      setState(() {

      });
    }
  }
  Future<void>completedsummary()async{
    completsummarys=true;
    if(mounted){
      setState(() {

      });
    }
    final Networkresponce networkresponce = await Networkcoller().getrequest(Urls.gettasksummary);
    if(networkresponce.isSuccess){
taskcountsummarymodel=Taskcountsummarymodel.fromJson(networkresponce.jsonresponce);
    }
    completsummarys=false;
    if(mounted){
      setState(() {

      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcompleted();
    completedsummary() ;
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
             visible: completsummarys==false,
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
                     summary: taskcount.id.toString(),
                 );
               }),
             ),
           ) ,
            Expanded(
              child: Visibility(
                visible: completeinpro==false,
                replacement: Center(child: CircularProgressIndicator()),
                child: RefreshIndicator(
                  onRefresh: getcompleted,
                  child: ListView.builder(
                      itemCount: newtask.data?.length??0,
                      itemBuilder: (context,index){
                       return Taskcard(

                         task: newtask.data![index],
                         onstatuschange: () {
                           getcompleted();
                         },
                         showprogress: (Inpgroee ) {
                           completeinpro =Inpgroee;
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
