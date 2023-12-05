import 'package:apps/data_network_coller/data_utility/urls.dart';
import 'package:apps/data_network_coller/model_api/newtask.dart';
import 'package:apps/data_network_coller/model_api/taskcountsummarymodel.dart';
import 'package:apps/data_network_coller/network_coller.dart';
import 'package:apps/data_network_coller/network_responce.dart';
import 'package:apps/widget/profile_summary.dart';
import 'package:apps/widget/summary_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widget/task_card.dart';

class Newscreen extends StatefulWidget {
  Newscreen({super.key});

  @override
  State<Newscreen> createState() => _NewscreenState();
}

class _NewscreenState extends State<Newscreen> {
  bool getapi = false;
  bool gettaskcountlist = false;

  Newtask newtask = Newtask();
  Taskcountsummarymodel taskcountsummarymodel = Taskcountsummarymodel();

  Future<void> getTaskcountsummarylist() async {
    gettaskcountlist = true;
    if (mounted) {
      setState(() {});
    }
    final Networkresponce responce =
        await Networkcoller().getrequest(Urls.gettasksummary);
    if (responce.isSuccess) {
      taskcountsummarymodel =
          Taskcountsummarymodel.fromJson(responce.jsonresponce);
    }
    gettaskcountlist = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> getnewscreen() async {
    getapi = true;
    if (mounted) {
      setState(() {});
    }
    final Networkresponce responce =
        await Networkcoller().getrequest(Urls.getnewtask);
    if (responce.isSuccess) {
      newtask = Newtask.fromJson(responce.jsonresponce);
    }
    getapi = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTaskcountsummarylist();
    getnewscreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Profilesummary(),

            Visibility(
                visible: gettaskcountlist == false &&
                    (taskcountsummarymodel.data?.isNotEmpty ?? false),
                replacement: LinearProgressIndicator(),
                child: SizedBox(
                  height: 120,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: taskcountsummarymodel.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        Taskcount taskcount =
                            taskcountsummarymodel.data![index];
                        return FittedBox(
                          child: Summarycard(
                              count: taskcount.sum.toString(),
                              summary: taskcount.id.toString()),
                        );
                      }),
                )),





            Expanded(
              child: Visibility(
                visible: getapi == false,
                replacement: Center(child: CircularProgressIndicator()),
                child: RefreshIndicator(
                  onRefresh: getnewscreen,
                  child: ListView.builder(
                      itemCount: newtask.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Taskcard(

                          task: newtask.data![index],
                          onstatuschange: () {
                            getnewscreen();
                          },
                          showprogress: (Inprogress) {
                            getapi = Inprogress;
                            if (mounted) {
                              setState(() {});
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
