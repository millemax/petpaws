import 'dart:math';

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //------declaramos variables para cambio de colores en botones
  Color left = Colors.black;
  Color right = Colors.white;

  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
                logo(),
                menuBar(),
                Container(
                    width: double.infinity,
                    height: 700,
                    child: PageView(
                      controller: _pageController,
                      //-------funcion para el controlde estados de estados
                      onPageChanged: (i) {
                        if (i == 0) {
                          setState(() {
                            right = Colors.white;
                            left = Colors.black;
                          });
                        } else if (i == 1) {
                          setState(() {
                            right = Colors.black;
                            left = Colors.white;
                          });
                        }
                      },
                      children: [
                        ConstrainedBox(
                            constraints: BoxConstraints.expand(),
                            child: ExistentePage()),
                        ConstrainedBox(
                            constraints: BoxConstraints.expand(),
                            child: NuevoPage()),
                      ],
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }

//----------------------------------------Ordenando--.--------------------------------------------
  Widget logo() {
    return Container(
      margin: EdgeInsets.only(top: 30, bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/logoblanco.png",
            height: 120,
          ),
        ],
      ),
    );
  }

//---------------------botones existente y nuevo-------
  Widget menuBar() {
    return Container(
      width: 300.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Color(0x552B2B2B),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: CustomPaint(
        painter: MyPainter(pageController: _pageController),
        child: Row(
          children: [
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  if (_pageController.hasClients) {
                    _pageController.animateToPage(
                      0,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.decelerate,
                    );
                  }
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                  child: Text(
                    "Existente",
                    style: TextStyle(color: left),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  if (_pageController.hasClients) {
                    _pageController.animateToPage(
                      1,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.decelerate,
                    );
                  }
                },
                child: Text(
                  "Nuevo",
                  style: TextStyle(
                    color: right,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//definimos custom paint para dibujar el cuadro que se va trasladar

class MyPainter extends CustomPainter {
  Paint painter;
  final double dxTarget;
  final double dxEntry;
  final double radius;
  final double dy;
  final PageController pageController;

  MyPainter(
      {this.dxTarget = 125.0,
      this.dxEntry = 25.0,
      this.radius = 21.0,
      this.dy = 25.0,
      this.pageController})
      : super(repaint: pageController) {
    painter = new Paint()
      ..color = Color(0xFFFFFFFF)
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final pos = pageController.position;
    double fullExtent =
        (pos.maxScrollExtent - pos.minScrollExtent + pos.viewportDimension);

    double pageOffset = pos.extentBefore / fullExtent;

    bool left2right = dxEntry < dxTarget;
    Offset entry = new Offset(left2right ? dxEntry : dxTarget, dy);
    Offset target = new Offset(left2right ? dxTarget : dxEntry, dy);

    Path path = new Path();
    path.addArc(
        new Rect.fromCircle(center: entry, radius: radius), 0.5 * pi, 1 * pi);
    path.addRect(
        new Rect.fromLTRB(entry.dx, dy - radius, target.dx, dy + radius));
    path.addArc(
        new Rect.fromCircle(center: target, radius: radius), 1.5 * pi, 1 * pi);

    canvas.translate(size.width * pageOffset, 0.0);
   // canvas.drawShadow(path, Color(0xFFfbab66), 3.0, true);
    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) => true;
}

//--------definimos las clases de las paginas ------
class ExistentePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          campologin(),
          textrecordarcontrasena(),
          lineaOnlogin(),
          iconlogin(),
        ],
      ),
    );
  }

  Widget campologin() {
    return Stack(
      children: [
        login(),
        botonlogin(),
      ],
    );
  }

  Widget login() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 2),
      padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 55),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              prefixIcon: Icon(Icons.email),
              labelText: "Email",
              hintText: "Email",
            ),
          ),
          SizedBox(height: 10),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
              prefixIcon: Icon(Icons.lock),
              labelText: "Contraseña",
              hintText: "Contraseña",
            ),
          ),
        ],
      ),
    );
  }

  Widget botonlogin() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          height: 170,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              height: 40.0,
              minWidth: 70.0,
              color: Colors.red,
              textColor: Colors.white,
              child: Text("INICIAR SESIÓN"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              onPressed: () {},
            )
          ],
        ),
      ],
    );
  }

  Widget textrecordarcontrasena() {
    return Column(
      children: [
        SizedBox(
          height: 25,
        ),
        Text(
          "¿Se te olvidó tu contraseña?",
          style: TextStyle(color: Colors.white, fontSize: 10),
        ),
      ],
    );
  }

  Widget lineaOnlogin() {
    return Container(
      margin: EdgeInsets.only(top: 30, bottom: 30),
      height: 3,
      width: 250,
      child: CustomPaint(
        painter: PaintLinea(),
      ),
    );
  }

  Widget iconlogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 25,
        ),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(130),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/fb-icon.png"))),
        ),
        SizedBox(width: 20),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(130),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/google-icon.png"))),
        ),
      ],
    );
  }
}

//Creamos la clase pintlinea para dibujar la linea, hereda de CustomPinter

class PaintLinea extends CustomPainter {
  @override
  //Metodo para definir la figura deseada
  void paint(Canvas canvas, Size size) {
    //crear objeto lapiz
    final lapiz = new Paint();
    lapiz.color = Colors.white;
    //grosor de lapiz
    lapiz.strokeWidth = 2;
    //stroke para contorno/fill fondo
    lapiz.style = PaintingStyle.stroke;
    //redondear esquinas de lo que dibuja lapiz
    lapiz.strokeCap = StrokeCap.round;

    //dibujamoa la figura
    final linealogin = new Path();

    linealogin.lineTo(size.width * 0.45, 0);
    linealogin.moveTo(size.width * 0.55, 0);
    linealogin.lineTo(size.width, 0);

    //fusionar lapiz y su funcion que le dimos
    canvas.drawPath(linealogin, lapiz);
  }

  //En que casos se redibujara la figura
  @override
  bool shouldRepaint(PaintLinea oldDelegate) => false;
}

//---------------------creamoa la pagina registro de nuevo ususario----
class NuevoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          campoRegistro(),
        ],
      ),
    );
  }

  Widget campoRegistro() {
    return Stack(
      children: [
        registro(),
        botonRegistro(),
      ],
    );
  }

  registro() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 2),
      padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 55),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              prefixIcon: Icon(Icons.person_outline),
              labelText: "Nombre",
              hintText: "Nombre",
            ),
          ),
          SizedBox(height: 10),
          TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
              prefixIcon: Icon(Icons.email),
              labelText: "Email",
              hintText: "Email",
            ),
          ),
          SizedBox(height: 10),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              prefixIcon: Icon(Icons.lock_outline),
              labelText: "Contraseña",
              hintText: "Contraseña",
            ),
          ),
          SizedBox(height: 10),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
              prefixIcon: Icon(Icons.lock_outline),
              labelText: "Contraseña",
              hintText: "Confirmar",
            ),
          ),
        ],
      ),
    );
  }

  botonRegistro() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          height: 310,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              height: 40.0,
              minWidth: 70.0,
              color: Colors.red,
              textColor: Colors.white,
              child: Text("INICIAR SESIÓN"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              onPressed: () {},
            )
          ],
        ),
      ],
    );
  }
}
