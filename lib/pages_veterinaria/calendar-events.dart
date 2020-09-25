
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:call_number/call_number.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class MyCalendar extends StatefulWidget {
  MyCalendar({Key key}) : super(key: key);

  @override
  _MyCalendarState createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {
  //-----waves------
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

  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();

  CalendarController _controller;

  //variable para obtener la fecha hora actual
  String _fecha;
  int _timeunix;

  @override
  void initState() {
    
    super.initState();

    //inicalizamos el calendario
    _controller = CalendarController();

    //variables de fecha y hora actual
    var fecha= DateTime.now();
    var horaactual=fecha.toUtc().millisecondsSinceEpoch;    
    
      
     setState(() {

       _fecha=DateFormat('EEEE, d MMMM, ' 'yyyy', 'es_ES').format(fecha);
       _timeunix= horaactual;

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
                     
                     getData(serviceId, _fecha,_timeunix);
                  
                     

                  });
                 

                },
                initialCalendarFormat: CalendarFormat.week,
                //availableCalendarFormats: {CalendarFormat.week: 'Semana'},
                
              
              ),
            ),

            Container(
              child: getData(serviceId, _fecha,_timeunix),
            ),

          ],
        ),
        
      ),

    );     
    
  }

  //funcion para recuperar todas las reservas 

  
   

  Widget getData(String serviceId, date, int timeunix) {    

    final String id = FirebaseAuth.instance.currentUser.uid;
    return  StreamBuilder(     
      stream: FirebaseFirestore.instance.collection('reservas').where('veterinaria', isEqualTo: id).where('servicio', isEqualTo: serviceId).where('fechainicioreserva', isEqualTo: date).where('fechareservaunix',isGreaterThanOrEqualTo:timeunix).orderBy('fechareservaunix',descending:false).snapshots(),
      builder: (_ , snapshot){
        if (!snapshot.hasData) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.93,
            child: Center(child: CircularProgressIndicator()),
          );
        } else {
          return Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.93,
              height: MediaQuery.of(context).size.height * 0.85,
              child: ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder:(BuildContext context, int index){
                  DocumentSnapshot data= snapshot.data.documents[index];
                  return cardprueba(data);
                  //tilecard(data);
                  
                }, 

                ),


            ),
          );
        }
      },
    );
  }

 
  //----encabezado de la pagina ---
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
            backgroundColor: Colors.deepPurpleAccent[400],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //----TITULO DE LA SECCION---
              Padding(
                padding: const EdgeInsets.only(
                  top: 15.0,
                ),
                child: Text(
                  "Reservaciones",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19.0,
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

    Widget cardprueba(data){
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ExpansionTile(
        title: ListTile(
          leading: Text(data.data()['horainicioreserva'], style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFFED278A)) ),
          title: Text(data.data()['nombredueno'], style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('Mascota : ${data.data()['nombremascota']}'),
          ),
        children:[

            Container(
              padding: EdgeInsets.symmetric(horizontal:40, vertical: 15),
              child: Column(
                children: [

                  Row(
                    children: [
                      Text.rich(
                            TextSpan(
                              style: TextStyle(fontWeight: FontWeight.bold),
                              text: 'Fecha :  ', // default text style
                              children: <TextSpan>[                                
                                TextSpan(text: '${data.data()['fechainicioreserva']}', style: TextStyle(fontWeight: FontWeight.normal)),
                              ],
                            ),
                          )
                    ],
                  ),

                  Row(
                    children: [
                      Text.rich(
                            TextSpan(
                              style: TextStyle(fontWeight: FontWeight.bold),
                              text: 'Mascota :  ', // default text style
                              children: <TextSpan>[                                
                                TextSpan(text: '${data.data()['nombremascota']}', style: TextStyle(fontWeight: FontWeight.normal)),
                              ],
                            ),
                          )
                    ],
                  ),
                  Row(
                    children: [
                      Text.rich(
                            TextSpan(
                              style: TextStyle(fontWeight: FontWeight.bold),
                              text: 'Especie :  ', // default text style
                              children: <TextSpan>[                                
                                TextSpan(text: '${data.data()['especie']}', style: TextStyle(fontWeight: FontWeight.normal)),
                              ],
                            ),
                          )
                    ],
                  ),

                  Row(
                    children: [
                      Text.rich(
                            TextSpan(
                              style: TextStyle(fontWeight: FontWeight.bold),
                              text: 'Telefono :  ', // default text style
                              children: <TextSpan>[                                
                                TextSpan(text: '${data.data()['celular']}', style: TextStyle(fontWeight: FontWeight.normal)),
                              ],
                            ),
                          )
                    ],
                  ),

                  SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        color: Color(0xFFED278A),                      
                        onPressed: (){
                          llamadas(data.data()['celular']);
                        }, 
                        child: Row(
                          children: [
                            Icon(Icons.call, color: Colors.white  ),
                            SizedBox(width:5),
                            Text('Llamar', style: TextStyle(color: Colors.white) ),

                          ],
                        ),

                      
                      ),
                    ],
                  ),

                ],


              ),

            ),

            


        ],
        
      )
    );

  }


  //funcion par hacer las llamadas
  llamadas(String numero) async {

    await new CallNumber().callNumber('+51'+numero);

    



  }



   
      


  
  


 

}
