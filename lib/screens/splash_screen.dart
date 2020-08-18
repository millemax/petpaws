import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';




class Splash extends StatefulWidget {
  Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {

    return new SplashScreen(
      seconds: 5,
      navigateAfterSeconds: new AfterSplash(),
      /* title: new Text('Cargando...',
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.0
      ),), */
      image: Image.asset('assets/images/logomorado.png'),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      onClick: ()=>print("Flutter Egypt"),
      loaderColor: Colors.pinkAccent      
    );
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
      title: new Text("Welcome In SplashScreen Package"),
      automaticallyImplyLeading: false
      ),
      body: new Center(
        child: new Text("Done!",
        style: new TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30.0
        ),),

      ),
    );
  }
}

