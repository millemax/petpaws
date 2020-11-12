import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:petpaws/bloc/login_bloc.dart';

import 'package:petpaws/page_administrador/localizacion.dart';

import 'package:petpaws/pages/misReservas.dart';
import 'package:petpaws/pages/perfilVeterinarias_page.dart';
import 'package:petpaws/pages/reservaService_page.dart';

import 'package:petpaws/pages_veterinaria/create-service.dart';
import 'package:petpaws/pages_veterinaria/horarios_atencion.dart';
import 'package:petpaws/pages_veterinaria/reservas.dart';
import 'package:petpaws/providers/ubicacion.dart';

import 'package:petpaws/screens/inicio.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:intl/date_symbol_data_local.dart';

import 'pages/homeVeterinarias_page.dart';

import 'pages/push_provider.dart';
import 'postergarReservaPage/calendar_postergacion_Page.dart';
import 'postergarReservaPage/reserva_postergacion_page.dart';

// importamos wavesanimaction

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //runApp(MyApp());
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  @override
  void initState() {
    super.initState();
    final pushProvider = new PushNotification();
    pushProvider.initNotificaions();

    pushProvider.mensajes.listen((event) {
      //Navigator.push(context, route)
      print('push argumento');
      print(event);

      navigatorKey.currentState.pushNamed('MisReservas');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => LoginBloc(),
      child: ChangeNotifierProvider(
        create: (_) => Ubicacioninfo(),
        child: MaterialApp(
            theme: ThemeData(
              primaryColor: Color(0xFF6600FF),
              primaryColorLight: Color(0xff80ced7),
              accentColor: Color(0xFF0100ca),
              canvasColor: Color(0xffb3ffff),
              cardColor: Colors.grey[300],
              fontFamily: 'McLaren',
              //fontFamily: 'McLaren',
            ),
            navigatorKey: navigatorKey,
            title: 'login iu',
            debugShowCheckedModeBanner: false,
            //home: LoginScreen(),
            // home: Inicio(),
            initialRoute: '/',
            // home: LoginPage(),
            routes: {
              '/': (context) => Inicio(),
              'perfilveterinarias': (context) => PerfilVeterinariaPage(),
              'HomeVeterinarias': (context) => HomeVeterinariasPage(),
              'crearservico': (context) =>
                  CreateServices(), //este es la pagina en el perfil de veterninarias

              'horariosatencion': (context) => HorarioAtencion(),
              'ReservaService': (context) =>
                  ReservaService(), //la pagina donde se llena el formulario para reservar cita
              // 'calendarevents': (context) => MyCalendar(),
              'PerfilUsuario': (context) => MisReservas(),

              'MisReservas': (context) =>
                  MisReservas(), // pagina donde vemos nuestro historial de reservas

              'reservasveterinario': (context) => ReservasPage(),
              //'actualizarservicio': (context) => ActualizarService(),
              'CalendarPostegar': (context) => CalendarPostegar(),
              'ReservaPostergacion': (context) => ReservaPostergacion(),
              'obtenerubicacion': (context) => ObtenerUbicacion(),
            }),
      ),
    );
  }
}
