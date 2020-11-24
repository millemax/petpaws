import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:petpaws/bloc/login_bloc.dart';
import 'package:petpaws/page_administrador/menu.dart';
import 'package:petpaws/pages/homeVeterinarias_page.dart';
import 'package:petpaws/pages_veterinaria/reservas.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

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
      backgroundColor: Theme.of(context).primaryColor,
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
      width: MediaQuery.of(context).size.width * 0.71,
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
                child: Text(
                  "Existente",
                  style: TextStyle(color: left),
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
class ExistentePage extends StatefulWidget {
  //-------recuperacion de contraseña--
  @override
  _ExistentePageState createState() => _ExistentePageState();
}

class _ExistentePageState extends State<ExistentePage> {
  //--------------------------------login con google ----------
  bool signInState = false;

  final FirebaseAuth auth = FirebaseAuth.instance;
  var name;
  var id;
  var email;

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  Future<void> _goglesignIn() async {
    GoogleSignInAccount signInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication signInAuthentication =
        await signInAccount.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        idToken: signInAuthentication.idToken,
        accessToken: signInAuthentication.accessToken);
    User user = (await auth.signInWithCredential(credential)).user;

    print("uuuuuuuuuuuuuuuuuuuuuuuuuuuu");
    print(user);
    print(user.uid);

    setState(() {
      name = user.displayName;
      email = user.email;
      id = user.uid;
      signInState = true;
    });
  }

  //-------------------------------fin login con google-------

  TextEditingController correoCtrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();

//-----------------------------crea  identificador de contraseña---------------
  bool _obscureText = true;
//----------------------------fin identificador de contraseña--------
  bool _autovalidate = false;

  String correoValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) return '*Requerido';
    if (!regex.hasMatch(value))
      return '*Ingrese un correo válido';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    //-----login facebook----

    final bloc = Provider.of<LoginBloc>(context);
    return Container(
      margin: EdgeInsets.only(top: 30),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          campologin(bloc),
          textolvidocontrasena(context),
          lineaOnlogin(),
          iconlogin(),
        ],
      ),
    );
  }

  Widget campologin(LoginBloc bloc) {
    return Stack(
      children: [login(bloc), botonlogin(bloc)],
    );
  }

  Widget login(LoginBloc bloc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.83,
          padding: EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 55),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              StreamBuilder<Object>(
                  stream: bloc.emailStream,
                  builder: (context, snapshot) {
                    return TextField(
                      onChanged: bloc.changeEmail,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        prefixIcon: Icon(Icons.email),
                        labelText: "Email",
                        hintText: "Email",
                        errorText: snapshot.error,
                      ),
                    );
                  }),
              SizedBox(height: 10),
              StreamBuilder<Object>(
                  stream: bloc.passwordStream,
                  builder: (context, snapshot) {
                    return TextField(
                      onChanged: bloc.changePassword,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40)),
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                              icon: Icon(_obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              }),
                          labelText: "Contraseña",
                          hintText: "Contraseña",
                          errorText: snapshot.error),
                    );
                  }),
            ],
          ),
        ),
      ],
    );
  }

  Widget botonlogin(LoginBloc bloc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StreamBuilder<bool>(
            stream: bloc.formValidStream,
            builder: (context, snapshot) {
              return Padding(
                padding: const EdgeInsets.only(top: 180.0),
                child: RaisedButton(
                    splashColor: Theme.of(context).primaryColor,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: Text(
                        'INICIAR SESIÓN',
                      ),
                    ),
                    disabledColor: Theme.of(context).primaryColorLight,
                    color: Theme.of(context).primaryColorLight,
                    disabledTextColor: Colors.black.withOpacity(0.8),
                    textColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    onPressed: snapshot.hasData
                        ? () => _loguear(bloc, context)
                        : null),
              );
            }),
      ],
    );
  }

//-----------------------------Widget para reestablecer contraseña--
  Widget textolvidocontrasena(context) {
    return Column(
      children: [
        SizedBox(
          height: 25,
        ),
        GestureDetector(
          child: Text(
            "¿Se te olvidó tu contraseña?",
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
          onTap: () {
            //---------------modal para restablecer contraseña
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  contentPadding: EdgeInsets.only(top: 10.0),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  content: Container(
                    width: 300.0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                'Restablecer Contraseña',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  correoCtrl.clear();
                                  Navigator.pop(context);
                                })
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Divider(
                          color: Theme.of(context).accentColor,
                          height: 4.0,
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                right: 15, left: 15, top: 10),
                            child: Column(
                              children: [
                                Text(
                                  'Ingrese su correo para poder restablecer su contraseña.',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Form(
                                  key: _formKey,
                                  autovalidate: _autovalidate,
                                  child: TextFormField(
                                    controller: correoCtrl,
                                    decoration: InputDecoration(
                                      labelText: "Correo",
                                      hintText: "Correo",
                                      //----llama los iconos declarados
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: Icon(
                                          Icons.mail_outline,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                    validator: correoValidator,
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 50.0),
                      child: RaisedButton(
                        splashColor: Theme.of(context).primaryColor,
                        onPressed: () {
                          restablecerContrasena(context);
                        },
                        color: Theme.of(context).primaryColorLight,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 55.0, vertical: 15.0),
                          child: Text(
                            "Enviar",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            );
            //---------------
          },
        ),
      ],
    );
  }

  void restablecerContrasena(BuildContext context) async {
    if (_formKey.currentState.validate()) {}
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: correoCtrl.text)
        .then(
      (value) {
        Navigator.pop(context);
        Fluttertoast.showToast(
          msg:
              "El enlace de restablecimiento de contraseña ha enviado su correo,"
              "utilícelo para cambiar la contraseña",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
        );
      },
    ).catchError((error) {
      Fluttertoast.showToast(
        msg: "Correo inválido",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
      );
    });
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
    return Container(
      child: SignInButton(
        Buttons.Google,
        text: "Iniciar con Google",
        onPressed: () async {
          _goglesignIn().then((value) {
            FirebaseFirestore.instance
                .collection('users')
                .where('correo', isEqualTo: email)
                .get()
                .then((value) {
              print(value.docs.length);
              if (value.docs.length == 0) {
                createuserGoogle();
              } else {
                Navigator.pushNamed(context, 'HomeVeterinarias');
              }
            });
          });
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        elevation: 10.0,
        padding: EdgeInsets.symmetric(
            vertical: 6.00,
            horizontal: MediaQuery.of(context).size.width * 0.09),
      ),
    );
  }

  //show alert dialog para las notificaciones
  _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: new Text("Suspendido"),
              content: new Text(
                  "Tu cuenta ha sido suspendido por infringir nuestras politicas."),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  _loguear(LoginBloc bloc, BuildContext context) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: bloc.email, password: bloc.contrasena)
        .then((user) {
      //recuperamos el rol que tiene el usuario para la navegacion de las pantallas
      final String id = FirebaseAuth.instance.currentUser.uid;
      FirebaseFirestore.instance
          .collection('users')
          .doc('' + id)
          .get()
          .then((data) {
        final String rol = data.data()['rol'];
        final bool estado = data.data()['estado'];
        print('este es el rol' + rol);

        switch (rol) {
          case 'usuario':
            {
              if (estado == true) {
                //redirigimos en la pantalla
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => HomeVeterinariasPage()),
                    (Route<dynamic> route) => false);
              } else {
                _showMaterialDialog();
              }
            }
            break;

          case 'veterinario':
            {
              if (estado == true) {
                //redirigimos en la pantalla
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => ReservasPage()),
                    (Route<dynamic> route) => false);
              } else {
                _showMaterialDialog();
              }
            }
            break;

          case 'administrador':
            {
              if (estado == true) {
                //redirigimos en la pantalla
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => MenuAdministrador()),
                    (Route<dynamic> route) => false);
              } else {
                _showMaterialDialog();
              }
            }
            break;

          default:
            {
              print('datos invalidos');
            }
            break;
        }
      });
    }).catchError((onError) {
      print('error no pudimos autenticarte !!! :(');
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.ERROR,
        body: Center(
          child: Text(
            ' No pudimos autenticarte ',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        title: 'This is Ignored',
        desc: 'This is also Ignored',
        btnOkOnPress: () {},
      )..show();
    });
  }

  //-----crear un usuario cuando inicie sesion con google

  createuserGoogle() {
    FirebaseFirestore.instance.collection('users').doc(id).set({
      'correo': email,
      'nombre': name,
      'rol': 'usuario',
      'estado': true,
    }).then((value) {
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.SUCCES,
        body: Center(
          child: Text(
            ' Bienvenido a la comunidad',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        title: 'This is Ignored',
        desc: 'This is also Ignored',
        btnOkOnPress: () {
          Navigator.pushNamed(context, 'HomeVeterinarias');
        },
      )..show();
    }).catchError((onError) {
      print("error al cargar los datos");
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.ERROR,
        body: Center(
          child: Text(
            ' Error en conexion ',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        title: 'This is Ignored',
        desc: 'This is also Ignored',
        //btnOkColor: Colors.yellow,
        btnOkOnPress: () {
          exit(0);
        },
      )..show();
    });
  }
}

//....................Creamos la clase pintlinea para dibujar la linea, hereda de CustomPinter................................................

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

//---------------------creamoa la pagina registro de nuevo usuario----------------------------------
class NuevoPage extends StatefulWidget {
  @override
  _NuevoPageState createState() => _NuevoPageState();
}

class _NuevoPageState extends State<NuevoPage> {
  //-----------------------------crea  identificador de contraseña---------------
  bool _obscureText = true;
  bool _obscureTexti = true;
//----------------------------fin identificador de contraseña--------

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<LoginBloc>(context);
    return Container(
      margin: EdgeInsets.only(top: 30),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          campoRegistro(bloc),
        ],
      ),
    );
  }

  Widget campoRegistro(LoginBloc bloc) {
    return Stack(
      children: [
        registro(bloc),
        botonRegistro(bloc),
      ],
    );
  }

  registro(LoginBloc bloc) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 2),
      padding: EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 55),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          StreamBuilder<Object>(
              stream: bloc.nombreStream,
              builder: (context, snapshot) {
                return TextField(
                  onChanged: bloc.changeNombres,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    prefixIcon: Icon(Icons.person_outline),
                    labelText: "Nombre completo",
                    hintText: "Nombre completo",
                    errorText: snapshot.error,
                  ),
                );
              }),
          SizedBox(height: 10),
          StreamBuilder<Object>(
              stream: bloc.emailStream,
              builder: (context, snapshot) {
                return TextField(
                  onChanged: bloc.changeEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40)),
                    prefixIcon: Icon(Icons.email),
                    labelText: "Correo",
                    hintText: "Correo",
                    errorText: snapshot.error,
                  ),
                );
              }),
          SizedBox(height: 10),
          StreamBuilder<Object>(
              stream: bloc.passwordStream,
              builder: (context, snapshot) {
                return TextField(
                  onChanged: bloc.changePassword,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      prefixIcon: Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                          icon: Icon(_obscureText
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          }),
                      labelText: "Contraseña",
                      hintText: "Contraseña",
                      errorText: snapshot.error),
                );
              }),
          SizedBox(height: 10),
          StreamBuilder<Object>(
              stream: bloc.passwordConfirmedStream,
              builder: (context, snapshot) {
                return TextField(
                  onChanged: bloc.changeConfirmPassword,
                  obscureText: _obscureTexti,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)),
                      prefixIcon: Icon(Icons.lock_outline),
                      labelText: "Confirmar Contraseña",
                      hintText: "Confirmar contraseña",
                      errorText: snapshot.error),
                );
              }),
          SizedBox(height: 10),
          StreamBuilder<Object>(
              stream: bloc.celularStream,
              builder: (context, snapshot) {
                return TextField(
                  onChanged: bloc.changeCelular,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40)),
                    prefixIcon: Icon(Icons.smartphone),
                    labelText: "Celular",
                    hintText: "Celular",
                    errorText: snapshot.error,
                  ),
                );
              }),
        ],
      ),
    );
  }

  botonRegistro(LoginBloc bloc) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          height: 395,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<Object>(
                stream: bloc.registerValidStream,
                builder: (context, snapshot) {
                  return RaisedButton(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: Text('REGISTRARSE'),
                      ),
                      disabledColor: Theme.of(context).primaryColorLight,
                      color: Theme.of(context).primaryColorLight,
                      disabledTextColor: Colors.black.withOpacity(0.8),
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      onPressed: snapshot.hasData
                          ? () => _createuser(bloc, context)
                          : null);
                })
          ],
        ),
      ],
    );
  }

  _createuser(LoginBloc bloc, BuildContext context) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: bloc.email, password: bloc.contrasena)
        .then((value) {
      final String id = FirebaseAuth.instance.currentUser.uid;

      FirebaseFirestore.instance.collection('users').doc('' + id).set({
        'correo': bloc.email,
        'nombre': bloc.nombre,
        'telefono': bloc.celular,
        'rol': 'usuario',
        'estado': true,
      }).then((value) {
        AwesomeDialog(
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.SUCCES,
          body: Center(
            child: Text(
              ' Bienvenido a la comunidad',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          title: 'This is Ignored',
          desc: 'This is also Ignored',
          btnOkOnPress: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => HomeVeterinariasPage()),
                (Route<dynamic> route) => false);
          },
        )..show();
      });
    }).catchError((onError) {
      print("error al cargar los datos");
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.ERROR,
        body: Center(
          child: Text(
            ' Error en conexion ',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        title: 'This is Ignored',
        desc: 'This is also Ignored',
        //btnOkColor: Colors.yellow,
        btnOkOnPress: () {},
      )..show();
    });
  }
}
