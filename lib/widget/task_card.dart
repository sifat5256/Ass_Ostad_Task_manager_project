import 'package:apps/data_network_coller/data_utility/urls.dart';
import 'package:apps/data_network_coller/model_api/newtask.dart';
import 'package:apps/data_network_coller/network_coller.dart';
import 'package:apps/data_network_coller/network_responce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TaskStatus {
  New,
  Progress,
  Completed,
  Cancelled,
}

class Taskcard extends StatefulWidget {
  Taskcard({
    super.key,
    required this.task,
    required this.onstatuschange,
    required this.showprogress,
  });

  final Task task;

  final VoidCallback onstatuschange;
  final Function(bool) showprogress;

  @override
  State<Taskcard> createState() => _TaskcardState();
}

class _TaskcardState extends State<Taskcard> {
  Future<void> updatetaskstatus(String status) async {
    widget.showprogress(true);
    final Networkresponce responce = await Networkcoller()
        .getrequest(Urls.updatedtaskstatus(widget.task.id ?? "", status));
    if (responce.isSuccess) {
      widget.onstatuschange();
    }
    widget.showprogress(false);
  }

  Future<void> delettask(String Deleid) async {
    widget.showprogress(true);
    final Networkresponce responce = await Networkcoller()
        .getrequest(Urls.Deketedid(Deleid));
    if (responce.isSuccess) {
      widget.onstatuschange();
    }
    widget.showprogress(false);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.task.title ?? "",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          Text(widget.task.description ?? ""),
          Text("Date: ${widget.task.createdDate}"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Chip(
                label: Text(
                  widget.task.status ?? "new",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.green,
              ),
              Wrap(
                children: [
                  IconButton(
                      onPressed: () {
                        delettask(widget.task.id.toString());
                      },
                      icon: Icon(Icons.delete_forever)),
                  IconButton(
                    onPressed: () {
                      showupgrade();
                    },
                    icon: Icon(Icons.edit),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  void showupgrade() {
    List<ListTile> items = TaskStatus.values
        .map((e) => ListTile(
              title: Text("${e.name}"),
              onTap: () {
                updatetaskstatus(e.name);
                Navigator.pop(context);
              },
            ))
        .toList();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Upgrade Task"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: items,
            ),
            actions: [
              ButtonBar(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancelled")),
                ],
              )
            ],
          );
        });
  }
}
