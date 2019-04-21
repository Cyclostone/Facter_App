import 'package:flutter/material.dart';
import 'package:fun_fact_app2/colors.dart';
import 'package:fun_fact_app2/facts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Facter',
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
// Bring out the chotu in me and then leave me
class Home extends StatefulWidget{
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{

Animation animation;
AnimationController animationController;

@override

void initState(){
  super.initState();
  animationController = new AnimationController(vsync: this, duration: new Duration(seconds: 2));
  animation = new CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn);
  animation.addListener((){
    this.setState((){});
  });
  animationController.forward();
}

@override
void dispose(){
  animationController.dispose();
  super.dispose();
}


  int factcounter = 0;
  int colorcounter = 0;
  void showfacts(){
    setState(() {
     dispfact = facts[factcounter];
     dispcolor = bgcolors[colorcounter]; 
     factcounter = factcounter < facts.length-1 ? factcounter+1 : 0;
     colorcounter = colorcounter < bgcolors.length-1 ? colorcounter+1 : 0;
     animationController.reset();
     animationController.forward();
    });
  }
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dispcolor,
      body: new Padding(
        padding: const EdgeInsets.symmetric(vertical: 75.0),
        child: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Align(
              alignment: Alignment.topLeft,
              child: new Text(
                "Did You Know?",
                style: TextStyle(color: Colors.white, fontSize: 30.0),
              ),
            ),
            new Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: new Opacity(
              opacity: animation.value*1,
              child: new Transform(
              transform: new Matrix4.translationValues(0.0, animation.value*50.0, 0.0),
              child: new Text(
              dispfact,
              style: TextStyle(color: Colors.orangeAccent, fontSize: 25.0, fontWeight: FontWeight.w400),
            ),
              ),
              ),
            ),
            new MaterialButton(
              color: Colors.blueAccent,
              minWidth: 16.0,
              child: new Text(
                "Show Another Fun Fact",
                style: TextStyle(fontSize: 15.0,color: dispcolor),
              ),
              onPressed:showfacts,
            )
          ],
        ),
      )
      )
    );
  }
}