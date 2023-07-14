import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:news_app/search_and_sort.dart';


void main() {
  runApp(const Birthday());
}

class Birthday extends StatefulWidget {
  const Birthday({Key? key}) : super(key: key);

  @override
  State<Birthday> createState() => _BirthdayState();
}
 String birthday="";
class _BirthdayState extends State<Birthday> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: Column(children: [ElevatedButton(onPressed: (){
        setState(() {
           birthday="Happy birthday to me";
        });
      }
          ,child: Text("Birthday")),
        Text(birthday).animate().tint(color: Colors.green)
      ],),),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FrontPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FrontPage extends StatefulWidget {
  const FrontPage({Key? key}) : super(key: key);

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;

  //final GlobalKey<SnappableState> _snappableKey = GlobalKey<SnappableState>();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 12),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController!);
    _animationController?.forward().whenComplete(() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SearchSort()),
      );
    });
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.purple.shade900,
          Colors.pink.shade900,
        ], begin: Alignment.topCenter)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Today's News",
                style: GoogleFonts.dangrek(fontSize: 50, color: Colors.white),
              )
                  .animate(delay: const Duration(seconds: 1))
                  .then(delay: const Duration(seconds: 2))
                  .fadeIn()
                  .slideX(duration: const Duration(seconds: 4))
                  .then(delay: const Duration(seconds: 1)),
              // Snappable(
              //   key: _snappableKey,
              //   onSnapped: () => const Text('Snapped..!!!'),
              //   child: Text(
              //     "Today's News",
              //     style: GoogleFonts.dangrek(fontSize: 50, color: Colors.white),
              //   ),
              // ),
              // ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.purple.shade900)),
              //   child: const Text('Snap / Reverse'),
              //   onPressed: () {
              //     SnappableState state = _snappableKey.currentState!;
              //     if (state.isInProgress) {
              //       // do nothing
              //       debugPrint("Animation is in progress, please wait!");
              //     } else if (state.isGone) {
              //       state.reset();
              //     } else {
              //       state.snap();
              //     }
              //   },
              // )
            ],
          ),
        ),
      ),
    );
  }
}
