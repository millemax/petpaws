import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //------declaramos variables para cambio de colores en botones
  Color left = Colors.white;
  Color right = Colors.black;

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
                      //-------funcion para el controlde estados de estados
                      onPageChanged: (i) {
                        if (i == 0) {
                          setState(() {
                            right = Colors.black;
                            left = Colors.white;
                          });
                        } else if (i == 1) {
                          setState(() {
                            right = Colors.white;
                            left = Colors.black;
                          });
                        }
                      },
                      children: [
                        ExistentePage(),
                        NuevoPage(),
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
            "assets/logoblanco.png",
            height: 120,
          ),
        ],
      ),
    );
  }

//---------------------botones existente y nuevo-------
  Widget menuBar() {
    return Container(
      height: 60,
      width: 300,
      padding: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          )),
      child: Row(
        children: [
          Expanded(
            child: FlatButton(
              color: Colors.deepPurple,
              shape: StadiumBorder(),
              onPressed: () {},
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
              onPressed: () {},
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
    );
  }
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
                  fit: BoxFit.cover, image: AssetImage("assets/fb-icon.png"))),
        ),
        SizedBox(width: 20),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(130),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/google-icon.png"))),
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
              hintText: "Contraseña",
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
