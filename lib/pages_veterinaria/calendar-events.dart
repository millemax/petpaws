import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


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

    final serviceId= ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Reservaciones')
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color(0xFFED278A), width:2),
              ),
              child: TableCalendar(
                calendarController: _controller,
                locale:'es_ES',
                calendarStyle: CalendarStyle(
                  todayColor: Color(0xFF6600FF),
                  selectedColor: Color(0xFFFDD400),

                ),
                onDaySelected: (date, events){
                  print(date.toIso8601String());
                  print("EL ID SERVICE : "+serviceId);
                  //getData(serviceId);

                },
                initialCalendarFormat: CalendarFormat.week,
                //availableCalendarFormats: {CalendarFormat.week: 'Semana'},
                
              
              ),
            ),
            
          ],
        ),
      ),

    );     
    
  }

  //funcion para recuperar todas las reservas 

  Widget getData(String serviceId){    

   print('obteniendo a la bd');

    final String id = FirebaseAuth.instance.currentUser.uid;
    return  StreamBuilder(     
      stream: FirebaseFirestore.instance.collection('reservas').snapshots(),
      builder: (_ , snapshot){
        if (!snapshot.hasData) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.93,
            child: Center(
              child: CircularProgressIndicator()
              ),
          );
          
        } else {
          return Center(
            child: Container(
              width: MediaQuery.of(context).size.width* 0.93,
              height: MediaQuery.of(context).size.height*0.85,
              child: ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder:(BuildContext context, int index){
                  DocumentSnapshot data= snapshot.data.documents[index];
                  return card(data);
                }, 

                ),


            ),
          );


        }

      },

    );
  }

  Widget card(data){
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(Icons.access_alarm),
        title: Text(data.data()['nombredueno'], style: TextStyle(color: Colors.black))



      ),
    );

  }


 

}





