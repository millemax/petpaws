import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


class MyCalendar extends StatefulWidget {
  MyCalendar({Key key}) : super(key: key);

  @override
  _MyCalendarState createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {

  CalendarController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //inicalizamos el calendario
    _controller = CalendarController();
  }



  @override
  Widget build(BuildContext context) {

    final nombreService= ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Reservaciones')
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TableCalendar(
              calendarController: _controller,
              locale:'es_ES',
              calendarStyle: CalendarStyle(
                todayColor: Color(0xFF6600FF),
                selectedColor: Color(0xFFFDD400),

              ),
            
            )
          ],
        ),
      ),
    );
       
    
  }
}





