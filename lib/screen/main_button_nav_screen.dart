
import 'package:apps/screen2/add_new_task.dart';
import 'package:apps/screen2/new_screen.dart';
import 'package:apps/screen2/progress_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screen2/cancelled_screen.dart';
import '../screen2/compelete_screen.dart';

class Mainbuttonnavscreen extends StatefulWidget {
  const Mainbuttonnavscreen({super.key});

  @override
  State<Mainbuttonnavscreen> createState() => _MainbuttonnavscreenState();
}

class _MainbuttonnavscreenState extends State<Mainbuttonnavscreen> {
  int _selectedcolor=0;
  List<Widget> _screen=[
    Newscreen(),
    Progressscreen(),
    Compeletescreen(),
    Cencelledscreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen[_selectedcolor],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedcolor,
        onTap: (index){
          _selectedcolor=index;
          setState(() {

          });
        },
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(icon:Icon(Icons.abc),label: "New"),
          BottomNavigationBarItem(icon: Icon(Icons.change_circle_outlined),label: "In progrss"),
          BottomNavigationBarItem(icon:Icon(Icons.done),label: "Completed"),
          BottomNavigationBarItem(icon: Icon(Icons.close),label: "Cancelled"),
        ],

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return Addnewtask();
          }));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
