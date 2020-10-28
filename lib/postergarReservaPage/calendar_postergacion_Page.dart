import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class CalendarPostegar extends StatefulWidget {
  @override
  _CalendarPostegarState createState() => _CalendarPostegarState();
}

class _CalendarPostegarState extends State<CalendarPostegar> {
  //---------wavess-------
  _buildCard({
    Config config,
    Color backgroundColor = Colors.transparent,
  }) {
    return WaveWidget(
      config: config,
      backgroundColor: backgroundColor,
      size: Size(
        double.infinity,
        150.0,
      ),
      waveAmplitude: 0,
    );
  }

  //-----fin   waves------
  String idveterinaria;
  String idservicio;
  //recuperar la lista de reservas
  var reservasRecuperado = [];

  //recuperar la lista de reservas a postergar
  var reservasPostergar = [];

  //-----controlodaor para calendartable--
  CalendarController _controller;
  //.....fecha cuando selecciona en duro y formateado
  DateTime daySelected;
  String fechaSelected;
  //.....control de estado para que primero recupere datos todo de reservas de la bd
  bool control = false;

  int duracionCita;
  Map horarios;
  int cupo;
  var precio;

  List daysHora;
  List<DateTime> daysFecha;
  var numeroreservas = {};
  List<int> reservas = new List();

  @override
  void initState() {
    //-----inicializar el controlador para usar el calendario--

    super.initState();
    _controller = CalendarController();
  }

  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //variable para recibir datos de perfil veterinaria
    List prodData = ModalRoute.of(context).settings.arguments;
    idveterinaria = prodData[0];
    idservicio = prodData[1];
    String veterinaria = prodData[2];
    String name = prodData[3];
    String idreserva = prodData[4];
    String nombremascota = prodData[5];
    print(name);
    getDatas();

    //variable para captar horas de iniicio y final del mapa
    int _horainicio;
    int _horafinal;
    //-------------------------
    int _anoFinal;
    int _mesFinal;
    int _diaFinal;

    //fecha final x mas que no se selccione toma la fecha de hoy dia
    DateTime fechaFinal;
    var today = DateTime.now();
    var fechaHoy = DateFormat('EEEE, d MMMM, ' 'yyyy', 'es_ES').format(today);
    var nombreDia = DateFormat('EEEE', 'es_ES').format(today);
    //probando valores para el año, mes, dia
    var nombreAno = DateFormat('yyyy', 'es_ES').format(today);
    var nombreMes = DateFormat('MM', 'es_ES').format(today);
    var numDia = DateFormat('dd').format(today);

    //asginar valores a las variables hora de inicio y final
    try {
      if (daySelected == null) {
        _horainicio = horarios['$nombreDia']['inicio'];
        _horafinal = horarios['$nombreDia']['final'];
        _anoFinal = int.parse(nombreAno);
        _mesFinal = int.parse(nombreMes);
        _diaFinal = int.parse(numDia);
      } else {
        var clickDay = DateFormat('EEEE', 'es_ES').format(daySelected);
        _horainicio = horarios['$clickDay']['inicio'];
        _horafinal = horarios['$clickDay']['final'];
        _anoFinal = int.parse(DateFormat('yyyy', 'es_ES').format(daySelected));
        _mesFinal = int.parse(DateFormat('MM', 'es_ES').format(daySelected));
        _diaFinal = int.parse(DateFormat('dd', 'es_ES').format(daySelected));
      }
    } catch (e) {
      print('lo sentimos no hay atención');
    }
    print('**********************************');
    print(_horainicio);
    print(_horafinal);
    print(_anoFinal);
    print(_mesFinal);
    print(_diaFinal);

    //lista para ir almacenando los tiempos sumado al intervalo
    daysHora = [];
    daysFecha = [];
    if (_horainicio != null && _horafinal != null) {
      DateTime startDate =
          new DateTime(_anoFinal, _mesFinal, _diaFinal, _horainicio, 00);
      DateTime endDate =
          new DateTime(_anoFinal, _mesFinal, _diaFinal, _horafinal, 00);
      DateTime tmp = DateTime(startDate.year, startDate.month, startDate.day,
          startDate.hour, startDate.minute);
      //ciclo while para generar las horas y guardarlo en la lista days
      do {
        var hora = DateFormat('h:mm a').format(tmp);
        daysHora.add(hora);
        daysFecha.add(tmp);
        tmp = tmp.add(new Duration(minutes: duracionCita));
      } while (DateTime(tmp.year, tmp.month, tmp.day, tmp.hour, tmp.minute) !=
          endDate);
    } else {}
    print('********************************');
    print(daysFecha);
    print(daysHora);
    print(duracionCita);
    print(horarios);

    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: SafeArea(
        child: control == false
            ? Container(
                color: Colors.white,
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Image.asset("assets/images/perrito.gif"),
                  ),
                ),
              )
            : Stack(
                children: [
                  titulo(),
                  Padding(
                    padding: EdgeInsets.only(top: 80.0),
                    child: ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.6),
                                width: 2),
                          ),
                          child: TableCalendar(
                            initialSelectedDay: DateTime.now(),
                            onDaySelected: _onDaySelected,
                            initialCalendarFormat: CalendarFormat.week,
                            availableCalendarFormats: {
                              CalendarFormat.week: 'Semana'
                            },
                            locale: 'es_ES',
                            calendarController: _controller,
                            calendarStyle: CalendarStyle(
                              todayColor: Theme.of(context).primaryColor,
                              todayStyle: TextStyle(
                                  //-----actual fecha------
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white),
                              //-----seleccion fecha----
                              selectedColor:
                                  Theme.of(context).primaryColorLight,
                              selectedStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            headerStyle: HeaderStyle(
                              centerHeaderTitle: true,
                            ),
                            startingDayOfWeek: StartingDayOfWeek.monday,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Container(
                                padding: EdgeInsets.only(left: 20, bottom: 20),
                                child: daySelected == null
                                    ? Text(
                                        '$fechaHoy',
                                        style: TextStyle(fontSize: 17),
                                      )
                                    : Text('$fechaSelected',
                                        style: TextStyle(fontSize: 17)))
                          ],
                        ),
                        Stack(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.65,
                              padding: EdgeInsets.only(
                                right: 20,
                                left: 20,
                              ),
                              child: GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 15,
                                  childAspectRatio: 3,
                                ),
                                itemCount: daysHora.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () async {
                                      int fecha1 = daysFecha[index]
                                          .toUtc()
                                          .millisecondsSinceEpoch;

                                      await getData(
                                          fecha1, idveterinaria, idservicio);
                                      print('citas existentes');
                                      print(reservasRecuperado.length);
                                      print(
                                          'este es de la base de datos cupos$cupo');

                                      if (daySelected == null) {
                                        fechaFinal = today;
                                      } else {
                                        fechaFinal = daySelected;
                                      }

                                      DateTime oneDaysAgo =
                                          today.subtract(new Duration(days: 1));

                                      int horahoy =
                                          today.toUtc().millisecondsSinceEpoch;

                                      if (fechaFinal.isAfter(oneDaysAgo) &&
                                          fecha1 >= horahoy) {
                                        if (reservasRecuperado.length != cupo) {
                                          Navigator.pushNamed(
                                              context, 'ReservaPostergacion',
                                              arguments: [
                                                name,
                                                daysHora[index],
                                                daysFecha[index],
                                                duracionCita,
                                                idservicio,
                                                idveterinaria,
                                                precio,
                                                veterinaria,
                                                idreserva,
                                                nombremascota,
                                              ]);
                                        } else {
                                          //------------------mensaje si no hay cuposs-----
                                          return showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (context) {
                                              return AlertDialog(
                                                contentPadding:
                                                    EdgeInsets.only(top: 10.0),
                                                elevation: 10,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                content: Container(
                                                  width: 300.0,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Container(
                                                        width: double.infinity,
                                                        child: Text(
                                                          'Cupos LLenos',
                                                          style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5.0,
                                                      ),
                                                      Divider(
                                                        color: Theme.of(context)
                                                            .accentColor,
                                                        height: 4.0,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 15,
                                                                left: 15,
                                                                top: 10),
                                                        child: Text(
                                                          'Lo sentimos a esta hora los $cupo cupos estan llenos.',
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                actions: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 12),
                                                    child: RaisedButton(
                                                      splashColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 120.0,
                                                              vertical: 8),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      color: Colors
                                                          .greenAccent[200],
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text('OK',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.5),
                                                              fontSize: 17)),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      } else {
                                        //-------------------mensaje de horario no disponible -----
                                        return showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (context) {
                                              return AlertDialog(
                                                contentPadding:
                                                    EdgeInsets.only(top: 10.0),
                                                elevation: 10,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                content: Container(
                                                  width: 300.0,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Container(
                                                        width: double.infinity,
                                                        child: Text(
                                                          'Horario no Disponible',
                                                          style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5.0,
                                                      ),
                                                      Divider(
                                                        color: Theme.of(context)
                                                            .accentColor,
                                                        height: 4.0,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 15,
                                                                left: 15,
                                                                top: 10),
                                                        child: Text(
                                                          'No puede postergar en un horario pasada a la fecha  y hora actual.',
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                actions: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 12),
                                                    child: RaisedButton(
                                                      splashColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 120.0,
                                                              vertical: 8),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      color: Colors
                                                          .greenAccent[200],
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text('OK',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.5),
                                                              fontSize: 17)),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            });
                                      }
                                    },
                                    child: Container(
                                      child: Center(
                                          child: Text(daysHora[index],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      decoration: BoxDecoration(
                                        color: reservas[index] == cupo
                                            ? Theme.of(context)
                                                .accentColor
                                                .withOpacity(0.2)
                                            : Theme.of(context)
                                                .accentColor
                                                .withOpacity(0.5),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        border: Border.all(
                                            color: Colors.grey[300],
                                            width: 1.0),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 100,
                        )
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }

  getData(int fecha, idVeterinaria, idServicio) async {
    await FirebaseFirestore.instance
        .collection('reservas')
        .where("fechareservaunix", isEqualTo: fecha)
        .where("veterinaria", isEqualTo: idVeterinaria)
        .where("servicio", isEqualTo: idServicio)
        .get()
        .then((value) {
      if (value != null) {
        reservasRecuperado.clear();
        value.docs.forEach((element) {
          reservasRecuperado.add(element.data());
        });
      }
    });
  }

  getDatas() async {
    await FirebaseFirestore.instance
        .collection('veterinarias')
        .doc(idveterinaria)
        .collection('servicios')
        .doc(idservicio)
        .get()
        .then((value) {
      setState(() {
        duracionCita = value.data()['duracioncita'];
        horarios = value.data()['horarios'];
        cupo = value.data()['cupo'];
        precio = value.data()['precio'];
      });
      lista();
    });
  }

  //cuando selecciona la fecha
  void _onDaySelected(DateTime day, List events) {
    setState(() {
      daySelected = day;
      fechaSelected = DateFormat('EEEE, d MMMM, ' 'yyyy', 'es_ES').format(day);
      print(fechaSelected);
    });
  }

  Widget titulo() {
    return Container(
      child: Stack(
        children: [
          _buildCard(
            config: CustomConfig(
              colors: [
                Colors.white70,
                Colors.white54,
                Colors.white30,
                Colors.white,
              ],
              durations: [32000, 21000, 18000, 5000],
              heightPercentages: [0.31, 0.35, 0.40, 0.41],
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //----WIDGET REGRESO A PERFIL VETERINARIA---
              Wrap(
                direction: Axis.vertical,
                alignment: WrapAlignment.center,
                runSpacing: 1.0,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                      left: 18,
                    ),
                    child: GestureDetector(
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              //----TITULO DE LA SECCION---
              Padding(
                padding: const EdgeInsets.only(
                  top: 15.0,
                  right: 100,
                ),
                child: Text(
                  "Elíge una fecha y una hora",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  lista() {
    final tamano = daysFecha.length;
    print('tamaño de array' + tamano.toString());
    var contador = 0;
    //numeroreservas = {};
    for (int i = 0; i < tamano; i++) {
      FirebaseFirestore.instance
          .collection('reservas')
          .where("fechareservaunix",
              isEqualTo: daysFecha[i].toUtc().millisecondsSinceEpoch)
          .where("veterinaria", isEqualTo: idveterinaria)
          .where("servicio", isEqualTo: idservicio)
          .get()
          .then((value) {
        numeroreservas[i] = value.docs.length;
        contador = contador + 1;
        print('contador' + contador.toString());

        print(numeroreservas);

        if (contador == tamano) {
          print("comienza a ordenar............");
          ordenar(tamano);
        }
      });
    }
  }

  ordenar(cantidad) {
    print('ordenando.............');
    reservas = [];
    for (int i = 0; i < cantidad; i++) {
      reservas.add(numeroreservas[i]);
      print(".....el array.....");

      print(reservas);
    }

    if (reservas.length == cantidad) {
      setState(() {
        control = true;
      });
    }
  }
}
