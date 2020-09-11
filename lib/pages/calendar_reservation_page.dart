import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//------table calendar--
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  CalendarPage({Key key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  //-----controlodaor para calendarn table--
  CalendarController _controller;
  //.....fecha cuando selecciona
  var fecha;
  DateTime daySelected;

  @override
  void initState() {
    //-----inicializar el controlador para usa el calendario--
    super.initState();

    _controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    var fechaSeleccionada;
    var date = DateTime.now();
    var horas = DateFormat(DateFormat.YEAR_MONTH_DAY, 'es_ES').format(date);

    List days = [];
    DateTime startDate = new DateTime(2020, 07, 20, 08, 00);
    DateTime endDate = new DateTime(2020, 07, 20, 19, 00);
    DateTime tmp = DateTime(startDate.year, startDate.month, startDate.day,
        startDate.hour, startDate.minute);
    while (DateTime(tmp.year, tmp.month, tmp.day, tmp.hour, tmp.minute) !=
        endDate) {
      var horita = DateFormat('h:mm a').format(tmp);
      days.add(horita);
      print('esta es la nueva hora probada $horita');
      tmp = tmp.add(new Duration(minutes: 60));
    }
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Seleccionar fecha y hora',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 500,
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0XFFED278A), width: 2)),
                  child: TableCalendar(
                    onDaySelected: _ondaySelected,
                    initialCalendarFormat: CalendarFormat.week,
                    availableCalendarFormats: {CalendarFormat.week: 'Semana'},
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
                      selectedColor: Color(0xFFFDD400),
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
                                '$horas',
                                style: TextStyle(fontSize: 20),
                              )
                            : Text('$fecha', style: TextStyle(fontSize: 20)))
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      height: 330,
                      padding: EdgeInsets.only(right: 20, left: 20),
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 3,
                        ),
                        itemCount: days.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              if (daySelected == null) {
                                fechaSeleccionada = horas;
                              } else {
                                fechaSeleccionada = daySelected;
                              }
                              print(fechaSeleccionada);
                              print(days[index]);
                            },
                            child: Container(
                              child: Center(
                                  child: Text(days[index],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold))),
                              decoration: BoxDecoration(
                                  color: Color(0XFFED278A),
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

//cuando selecciona la fecha
  void _ondaySelected(DateTime day, List events) {
    setState(() {
      daySelected = day;
      fecha = DateFormat(DateFormat.YEAR_MONTH_DAY, 'es_ES').format(day);
    });
  }
}
