import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: HomePage(),
));

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

//
  int seconds =0, minutes =0, hours =0;
  String digitSeconds = "00", digitMinutes = "00", digitHours = "00";
  Timer? timer;
  bool started = false;
  List laps = [];

  get style => null;

  // Creating the Stop Timer Function

  void stop(){
    timer!.cancel();
    setState(() {
      started =  false;
    });
  }

  // Creating the reset function

  void reset() {
    timer!.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;

      digitHours = "00";
      digitMinutes = "00";
      digitSeconds = "00";

      started = false;


    });
  }
   void addLaps() {
    String lap = "$digitHours:$digitMinutes:$digitSeconds";
    setState(() {
      laps.add(lap);
    });
   }

   // Creating the start timer function
  void start() {
    started = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int localSeconds = seconds + 1;
      int localMinutes = minutes;
      int localHours = hours;

      if (localSeconds > 59) {
        if (localMinutes > 59) {
          localHours++;
          localMinutes = 0;
        } else {
          localMinutes++;
          localSeconds = 0;
        }
      }
      setState(() {
        seconds = localSeconds;
        minutes = localMinutes;
        hours = localHours;

        digitSeconds = (seconds >= 10 ? "$seconds" : "0$seconds");
        digitMinutes = (minutes >= 10 ? "$minutes" : "0$minutes");
        digitHours = (hours >= 10 ? "$hours" : "0$hours");
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.indigo[900],
       body: SafeArea(
         child: Padding(
       padding: const EdgeInsets.all(16.0),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Center(
      child: Text(
     "StopWatch App",
     style: GoogleFonts.cormorant(
       textStyle: style,
       fontWeight: FontWeight.bold,
       fontSize: 50,
       color: Colors.amber[600],
     ),
    ),
    ),
      Container(
        height:200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.yellowAccent,
              width: 4,
            ),
          ),
          child: Center(
            child: Text(
          "$digitHours:$digitMinutes:$digitSeconds",
          style: TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.w600,
          ),
        ),
        ),
      ),

      Container(
     height:400,
      decoration: BoxDecoration(
     color: Color(0xFF323F68),
     borderRadius: BorderRadius.circular(8),
    ),
             child: ListView.builder(
              itemCount: laps.length,
              itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(15.0),
               child:
               Column(
                    children:[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                    Text(
                   "Lap ${index +1}",
                   style: TextStyle(
                     color: Colors.white,
                     fontWeight: FontWeight.bold,
                     fontSize: 16.0,
                   ),
                 ),
                    Text(
                   "${laps[index]}",
                   style: TextStyle(color: Colors.yellow,
                   fontSize: 16.0,
                   fontWeight: FontWeight.bold),
                 ),
                ],
                      ),
                    Divider(
                   color: Colors.grey,
                      thickness: 1,
                 ),
                ],
                  ),
            );
          },
        ),
       ),


         Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
     children: [
       Expanded(
        child: RawMaterialButton(
        onPressed: () {
          (!started) ?start():stop();
        },

         shape: const StadiumBorder(
            side: BorderSide(color: Colors.yellowAccent),
    ),
         child: Text(
           (!started) ? "Start": "Pause",
        style: TextStyle(color: Colors.white,
            fontWeight: FontWeight.bold,
        fontSize: 15),
     ),
       ),
       ),
       SizedBox(
       width: 8.0,
       ),
       IconButton(
         onPressed: () {
           addLaps();
         },
          icon:Icon(Icons.flag,
          color: Colors.yellowAccent),
       ),
       SizedBox(
         width: 8.0,
       ),
        Expanded(
         child: RawMaterialButton(
          onPressed: () {
            reset();
          },
           shape: const StadiumBorder(
             side: BorderSide(color: Colors.yellowAccent),
    ),
           child: Text(
             "Reset",
             style: TextStyle(color: Colors.white,
                 fontWeight: FontWeight.bold,
             fontSize: 15),
           ),
         ),
    ),
    ],
    )
           ],
       ),
      ),
    ),
    );


  }
}
