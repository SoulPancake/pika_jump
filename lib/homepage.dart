import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flappy_guthrie/barrier.dart';
import 'package:flappy_guthrie/guthrie.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  static double birdY=0; //Initially we'll place the block on the center
  // We'll Write a Method to simulate the jumps!
  AudioCache cache=AudioCache(); // you have this
  AudioPlayer player=AudioPlayer(); // create this
 double initialPosition= birdY;
 double height=0;
 double time=0;
 double gravity = -4.9; //The g/2 part
  double velocity = 3.5;  //How strong the jump is ,Lowered the velocity because those jumps were too strong (Like me)
 double birdWidth=0.1;
 double birdHeight=0.1;
 static int score=0;
 static int bestScore=0;
 String Score=score.toString();
 String BestScore=bestScore.toString();
  //Game settings
  bool gameHasStarted=false;

  //Variables for Barriers
  static List<double> barrierX=[2,2+1.5];
  static double barrierWidth=0.5; //Out of 2
  List<List<double>> barrierHeight=[
    //OUT OF 2
    //Where 2 is the entire height of the screen
    //These pairs are -> [top height,BottomHeight]
    [0.6,0.4],
    [0.4,0.6],
  ];
  void _playFile() async{
    player = await cache.play('aud.wav'); // assign player here
  }

  void _stopFile() {
    player.stop(); // stop the file like this
  }

  //This is now literally Perfect heheheheh


  void startGame(){
    //We'll call this using a gesture detector
    if(!gameHasStarted)
      _playFile();
   gameHasStarted=true; //Self explanatory
    Timer.periodic(Duration(milliseconds: 60), (timer) {
  //Every 40 milliseconds this equation is going to calculate a new height
      //For our Pikachu
      //So we would need to use a setState to update the bird's POS

      //The equation would be
      //Y = 4.9 time * time + 28 * time

      height = gravity * time * time + velocity * time;



      setState(() {
        // birdY=initialPosition-height; //This would essentially move the block upwards!
        Score=score.toString();
         BestScore=bestScore.toString();

        birdY=initialPosition-height;

      });

      if(pikachuDead())
        {
          bestScore=max(bestScore,score);
          BestScore=bestScore.toString();
          score=0;
          _stopFile();
          timer.cancel();
          gameHasStarted=false;
          _showDialog();
        }


      //Lowkey thinking of changing this game's name to Pika Jump!
      //Gonna do it
      //HEHEE


      //Moving the barriers
      moveMap();


      time+=0.05; //Keep the time moving forward
      score++;
    });
  }

  void moveMap()
  {
    for(int i=0;i<barrierX.length;i++)
      {
        setState(() {
          barrierX[i]-=0.005;
        });
      }
  }

  void resetGame()
  {
    Navigator.pop(context);
    //This would dismiss the alert box

    setState(() {
      birdY=0;
      gameHasStarted=false;
      time=0;
      initialPosition=birdY;
      barrierX=[2,2+1.5];
    });
  }

  void _showDialog()
  {
    showDialog(context: context,
        barrierDismissible:false,
        builder: (BuildContext context){
       return AlertDialog(
         backgroundColor: Colors.brown,
         title: Center(
           child: Text("G A M E  O V E R",style: TextStyle(color: Colors.white),),
         ),
         actions: [
           GestureDetector(
             onTap: resetGame,
             child: ClipRRect(
               borderRadius: BorderRadius.circular(5),
               child: Container(
                 padding: EdgeInsets.all(7),
                 color: Colors.white,
                 child: Text(
                   "PLAY AGAIN",
                   style: TextStyle(color: Colors.brown),
                 ),
               ),
             ),
           )
         ],
       );
        });
  }

  void jump()
  {

    setState(() {
      time=0; //resets time back to zero
      initialPosition=birdY; //This is used so that the next Jump occurs from where the block currently is
      //Block -> Pikachu (Formerly Guthrie Govan )
      
    });

    //Whenever Jump occurs again we need to set our time to zero
  }

  bool pikachuDead()
  {
    if(birdY<-1 || birdY>1) //Adding this condition for the boundary thing
        {
     return true; //Just a good practise to wrap things properly in proper brackets

    }

    for(int i=0;i<barrierX.length;i++)
    {
      if(barrierX[i]<=birdWidth && barrierX[i]+barrierWidth>=-birdWidth &&
          (birdY<=-1 + barrierHeight[i][0] || birdY+birdHeight >= 1 -barrierHeight[i][1])){
        return true; //This is when pikachu hits the barriers and dies
      }
    }


    return false;
  }


  //Modularizing this because later we need to check if Pikachu (formerly Guthrie) hits barriers



  //Checking if Pikachu (formerly Guthrie) is wihtin the x coordinates and y coordinates of barriers



  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: gameHasStarted?jump:startGame,
      child: Scaffold(
        body: Column(
          children: [

            Expanded(flex:3,
              child: Container(
                color:Colors.lightBlueAccent,

               child:Center(
              child:Stack(

                children: [


                MyGuthrie(
                  birdY: birdY,
                  birdHeight: birdHeight,
                  birdWidth: birdWidth,
                ),


                  //Let us add the barriers right here


                  //this is the top barrier zero
                  // MyBarrier(isThisTheBottomBarrier: false,
                  // barrierX: barrierX[0],
                  // barrierWidth: barrierWidth,
                  // barrierHeight: barrierHeight[0][0],),
                  //
                  // //Bottom barrier zero
                  // MyBarrier(isThisTheBottomBarrier: true,
                  // barrierX: barrierX[0],
                  // barrierWidth: barrierWidth,
                  // barrierHeight: [0][1],),
                  //
                  // //top barrier 1
                  //
                  // MyBarrier(isThisTheBottomBarrier: false,barrierX: barrierX[0],
                  // barrierWidth: barrierWidth,
                  // barrierHeight: barrierHeight[1][0],),
                  //
                  // //Bottom Barrier 1
                  // MyBarrier(isThisTheBottomBarrier: true,
                  // barrierX: barrierX[1],
                  //   barrierWidth: barrierWidth,
                  //   barrierHeight: barrierHeight[1][1],
                  // ),

            ],
              ),
            ),
            ),
            ),
            Expanded(child: Container(color:Colors.redAccent,
                child: Container(
                  alignment: Alignment(0,-0.5),
                  child: Column(
                    children: [
                      SizedBox(

                        height: 20.0,

                      ),
                      Center(
                        child: Text(gameHasStarted?'':'T A P  T O  P L A Y',
                          style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),
                        ),
                      ),

                      Expanded(
                        child: Container(
                          color: Colors.redAccent,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      Score,
                                      style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      'S C O R E',
                                      style: TextStyle(color: Colors.white, fontSize: 20),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      BestScore,
                                      style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      'B E S T',
                                      style: TextStyle(color: Colors.white, fontSize: 20),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),




                      Center(
                        child: Text('Anurag',
                          style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                )),)
          ],
        ),
      ),
    );
  }
}
