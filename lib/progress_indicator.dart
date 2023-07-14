
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProgressIndicatorExample extends StatefulWidget {
  const ProgressIndicatorExample({Key? key}) : super(key: key);

  @override
  State<ProgressIndicatorExample> createState() =>
      _ProgressIndicatorExampleState();
}

class _ProgressIndicatorExampleState extends State<ProgressIndicatorExample>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
      reverseDuration: const Duration(seconds: 0),
    )..addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.purple.shade900,Colors.pink.shade900,],begin: Alignment.topCenter)),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Loading....',
                style: GoogleFonts.raleway(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20,10,20,10),
                child: LinearProgressIndicator(backgroundColor:Colors.white,color: Colors.indigo.shade900,minHeight: 12,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
