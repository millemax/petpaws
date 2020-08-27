import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petpaws/pages/reservation-page.dart';

class PerfilVeterinariaPage extends StatefulWidget {
  @override
  _PerfilVeterinariaPageState createState() => _PerfilVeterinariaPageState();
}

class _PerfilVeterinariaPageState extends State<PerfilVeterinariaPage> {

// con esta funcion estamos recuperando los servicios de la veterinaria
  _getdata() async{
    await FirebaseFirestore.instance.collection('veterinarias').get().then((data){
      print('estos son los datos $data');
      data.docs.forEach((document){
        print(document.data());
        print(document.id);

      });

    });
    
   

  }
  @override
  void initState() {
    super.initState();
    _getdata();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            imagenFondo(),
            campoServicios(),
          ],
        ),
      ),
    );
  }

  Widget imagenFondo() {
    return Container(
      padding: EdgeInsets.only(bottom:500),
      height: double.infinity,
      width: double.infinity,
      
      child: Stack(
        children: [
          Image.asset('assets/images/fotoveterinaria.jpg', fit: BoxFit.cover, width: double.infinity,),
          Container(
            color: Color.fromRGBO(0, 0, 0, 0.3),           


          ),

        ],
      ),
      
    );
  }

  Widget campoServicios() {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 200),
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(60),
                topRight: Radius.circular(60),
              ),
            ),
            child: Column(
              children: [
                //-----------------titulo de veterinaria ----
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                  child: Column(
                    children: [
                      SizedBox(height:10),
                      Text(
                        "VETERINARIA LOAYZA",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                          "Nuestar veterinaria esta comprometido contigo por eso, trabajamos con 3 profesionales Médicos Veterinarios y 3 personas certificadas en grooming.",
                           textAlign: TextAlign.center,

                          ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 20,
                          bottom: 15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "SERVICIOS",
                              style: TextStyle(
                                color: Colors.yellow,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //----------------los cards
                servicios(),
               // servicios(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget servicios() {
    return Center(
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(
            children: [
              //------------------contenedor del card---
              Container(
                height: 200,
                margin: EdgeInsets.all(5),
                child: GestureDetector(
                    onTap: (){
                      Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Reservation(),
                                    ),
                                  );

                    },
                    child: Card(
                    color: Colors.yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //----------titulo del servicio----
                        Text("Desparacitacion",style: TextStyle(color: Colors.white, fontSize: 20),),
                        //------------------Icono o imagen del servicio---
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10, top: 10),
                          child: Icon(
                            Icons.beach_access,
                            size: 80,
                            color: Colors.white,
                          ),
                        ),
                    
                      ],
                    ),
                  ),
                ),
              ),

              //-------------------
              Container(
                height: 200,
                margin: EdgeInsets.all(5),
                child: Card(
                  color: Colors.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //----------titulo del servicio----
                      Text("Desparacitacion", style: TextStyle(color: Colors.white,fontSize: 20),),
                      //------------------Icono o imagen del servicio---
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, top: 10),
                        child: Icon(
                          Icons.beach_access,
                          size: 80,
                          color: Colors.white,
                        ),
                      ),
                      
                    
                    ],
                  ),
                ),
              ),          



            ],
          ),
        ],
      ),
    );
  }

  //----------
  Widget servicios1() {
    return Center(
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(
            children: [
              //------------------contenedor del card---
              Container(
                height: 200,
                margin: EdgeInsets.all(5),
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //----------titulo del servicio----
                      Text("Desparacitacion"),
                      //------------------Icono o imagen del servicio---
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, top: 10),
                        child: Icon(
                          Icons.beach_access,
                          size: 80,
                          color: Colors.amber,
                        ),
                      ),
                      //------------------footer del card ------------
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              //-------------------
              Container(
                height: 200,
                margin: EdgeInsets.all(5),
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //----------titulo del servicio----
                      Text("Desparacitacion"),
                      //------------------Icono o imagen del servicio---
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, top: 10),
                        child: Icon(
                          Icons.beach_access,
                          size: 80,
                          color: Colors.amber,
                        ),
                      ),
                      //------------------footer del card ------------
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //-----------
}
