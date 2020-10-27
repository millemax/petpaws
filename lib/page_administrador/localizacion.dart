import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:petpaws/page_administrador/menu.dart';

class ObtenerUbicacion extends StatefulWidget {
  ObtenerUbicacion({Key key}) : super(key: key);

  @override
  _ObtenerUbicacionState createState() => _ObtenerUbicacionState();
}

class _ObtenerUbicacionState extends State<ObtenerUbicacion> {

  TextEditingController direccionCtrl = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  //creamos un nuevo markador
  Set<Marker> markers= new Set<Marker>();

  GeoPoint latlong;

  

  double _latitud;
  double _longitud;

  bool _estado = false;

@override
void initState() { 
  getPosition();
  super.initState();
  
}

//funcion para obtener la ubicacion
  //funcion para obtener mi posicion
  getPosition() async {
    Position position =
        await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
    setState(() {
      _latitud = position.latitude;
      _longitud = position.longitude;
    });

    addMarker(position.latitude, position.longitude);
  }



//funcion para generar el markador
  addMarker(double latitude, double longitude){

    final Marker marker= Marker(
    draggable: true,
    markerId: new MarkerId('123456'),
    position: LatLng(latitude, longitude),
    infoWindow: InfoWindow(
      title: "Esta es tu direccion",
      snippet: "tu ubicacion",      
    ),
    onDragEnd: (newPosition){
      print(newPosition.latitude);
      print(newPosition.longitude);
      getAdress(newPosition.latitude, newPosition.longitude);

    },
  
  );

    getAdress(latitude, longitude);

    setState(() {
      markers.add(marker);
      _estado =true;
    });
  }



  //funcion para obtener el lugar
  getAdress(double lat, double long) async {
    final coordinates = new Coordinates(lat, long);
    var direcciones =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);

    // print(direcciones.first.featureName);
    print(direcciones.first.addressLine);

    setState(() {
     direccionCtrl.text= direcciones.first.addressLine;
    });

    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      appBar: AppBar(
        title: Text('Arrastra el marcador')
      ),


      body: _estado==false? Container(
       child: Center(
         child: CircularProgressIndicator(),
       ),
      )
      : Stack(
              children: [ 
                GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(_latitud, _longitud),
                  zoom: 12,
                ),
                markers: markers,                
                ),
                

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Form(                  
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(                                               
                          controller: direccionCtrl,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: BorderSide(color: Color(0xFF6600FF)),
                            
                            ),
                            hoverColor: Colors.red,
                            prefixIcon: Icon(Icons.add_location, color: Color(0xFF6600FF)),
                            labelText: 'Busca tu direccion',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(40),),

                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'busque una direccion';
                              
                            } else {
                              return null;
                            }
                          },
                        ),
                      ],
                    )
                    ),
                ),
 


              ]
      ),

       floatingActionButton: FloatingActionButton(
        onPressed: () {
          var ubicacion= new GeoPoint(_latitud, _longitud);

          if (_formKey.currentState.validate()) {

            //Navigator.push(context, MaterialPageRoute(builder: (context) => CrearVeterinaria() )  );7

            print('la latitud y longitud button ... : ');
            print(ubicacion.latitude);
            print(ubicacion.longitude);
            print('la direccion'+ direccionCtrl.text );
            Navigator.push(context,
            MaterialPageRoute(builder: (context) => MenuAdministrador() ));
                  
          }

          
        },
        child:Icon(Icons.check),
        backgroundColor: Color(0xFF6600FF),
        elevation: 10,
        

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
       
    );
  }


}