import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';


class MyCalendar extends StatefulWidget {
  MyCalendar({Key key}) : super(key: key);

  @override
  _MyCalendarState createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {

  CalendarController _controller;

  //variable para obtener la fecha actual
  String _fecha;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //inicalizamos el calendario
    _controller = CalendarController();

    var fecha= DateTime.now();

     print(DateFormat('EEEE, d MMMM, ' 'yyyy', 'es_ES').format(fecha));
    
      
     setState(() {

       _fecha=DateFormat('EEEE, d MMMM, ' 'yyyy', 'es_ES').format(fecha);

     });



   
    

  
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
                  var fechaselect= DateFormat('EEEE, d MMMM, ' 'yyyy', 'es_ES').format(date);               
                  setState(() {
                    _fecha= fechaselect;                    
                     
                     getData(serviceId, _fecha);
                     

                  });
                 

                },
                initialCalendarFormat: CalendarFormat.week,
                //availableCalendarFormats: {CalendarFormat.week: 'Semana'},
                
              
              ),
            ),

            Container(
              child: getData(serviceId, _fecha),
            ),

          ],
        ),
        
      ),

    );     
    
  }

  //funcion para recuperar todas las reservas 

  Widget getData(String serviceId , date){    
   

   print('obteniendo a la bd');

    final String id = FirebaseAuth.instance.currentUser.uid;
    return  StreamBuilder(     
      stream: FirebaseFirestore.instance.collection('reservas').where('veterinaria', isEqualTo: id).where('servicio', isEqualTo: serviceId).where('fechainicioreserva', isEqualTo: date).orderBy('fechareservaunix',descending:false).snapshots(),
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
        leading: Text(data.data()['horainicioreserva']),
        title: Text(data.data()['nombredueno'], style: TextStyle(color: Colors.black))



      ),
    );

  }

  


 

}





