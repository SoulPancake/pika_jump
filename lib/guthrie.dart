import 'package:flutter/material.dart';

class MyGuthrie extends StatelessWidget {

  final birdY;
  final double birdWidth; //Normal double value for width
  final double birdHeight; //Out of 2,2 being the entire height of the screen

   MyGuthrie({this.birdY,
   required this.birdWidth,
   required this.birdHeight});


  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0,(2* birdY+birdHeight)/(2-birdHeight)),

      child: Image.asset('lib/images/pikachu.png',
        // height: MediaQuery.of(context).size.height*3/4*birdHeight/2,
        // width: MediaQuery.of(context).size.height*birdWidth/2,
        height: 75,
      width: 64,

      fit: BoxFit.fill,),
      //It's the same thing but with an image in a different file
    );
  }
}
//yayyaaay
//Doenst work