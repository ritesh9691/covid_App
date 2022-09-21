import 'dart:async';
import 'package:corona_project/view/world_states.dart';
import 'package:flutter/material.dart';
import "dart:math" as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(

      duration: const Duration(seconds: 2),
      vsync: this)..repeat();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {

      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return  WorldStates();
        },
      ));

    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height ,
          width: MediaQuery.of(context).size.width ,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [

              AnimatedBuilder(
                  animation: _controller,
                  child: Container(
                    height: 200,
                    width: 200,
                    child: Center(
                      child: Image.asset('images/virus.png'),
                    //  child: Image(image: AssetImage('images/virus.png'),),
                    ),
                  ),
                  builder: (BuildContext context, Widget? child){
                    return Transform.rotate(angle: _controller.value * 2.0 * math.pi,
                        child: child
                    );
                  }),

              SizedBox(height: 50,),

              Text("Covid-19 \nTracker App", style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white,

              ),)

            ],
          ),
        ),
      ),
    );
  }
}