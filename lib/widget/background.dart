
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Backgroundimage extends StatelessWidget {
  final Widget child;
   Backgroundimage({required this.child});

  @override
  Widget build(BuildContext context) {
    return  Stack(children:[
      SvgPicture.asset("assets/images/background.svg",
        height: double.infinity,width: double.infinity,fit: BoxFit.cover),
        child
    ]
    );

  }
}
