import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {

  final barrierWidth; //Out of 2
  final barrierHeight; //A proportion of the ScreenHeight
  final barrierX;
  final bool isThisTheBottomBarrier;
  MyBarrier(
  {
    this.barrierHeight,
    this.barrierWidth,
    required this.isThisTheBottomBarrier,
    this.barrierX
});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment:  Alignment((2*barrierX+barrierWidth)/(2-barrierWidth),
      isThisTheBottomBarrier?1:-1),
      //If it is the bottom barrier it is going to be aligned at 1

      child: Container(
        color:Colors.green,
        width: MediaQuery.of(context).size.width*barrierWidth/2,
        height: MediaQuery.of(context).size.height*3/4*barrierHeight/2,

      ),
    );
  }
}
