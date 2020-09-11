import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';

class ReservaService extends StatefulWidget {
  ReservaService({Key key}) : super(key: key);

  @override
  _ReservaServiceState createState() => _ReservaServiceState();
}

class _ReservaServiceState extends State<ReservaService> {
  //-----------DropdownButton-------------
  int _value = 1;
  int _valor = 1;
  //-----------------NUMERO TELEFONICO-----
  String phoneNumber;
  String phoneIsoCode;
  bool visible = false;
  String confirmedNumber = '';

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    print(number);
    setState(() {
      phoneNumber = number;
      phoneIsoCode = isoCode;
    });
  }

  onValidPhoneNumber(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      visible = true;
      confirmedNumber = internationalizedPhoneNumber;
    });
  }
  //------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        title: Text(
          "Solicitar cita",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color(0xff572364)),
        ),
      ), */
      body: SafeArea(
        //-----------------container general-----
        child: Container(
          color: Color(0xff757575),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            //--------la columana contenedorrr
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //------------------container de cabecera---
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 20.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 130),
                              child: Icon(
                                Icons.arrow_back,
                                color: Color(0xffFFFFFF),
                              ),
                            ),
                            Text(
                              "Solicitar cita",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Color(0xffFFFFFF)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //---------Nombre del servicio
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 15),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                "BAÑOS Y PELUQUERIA",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "30 minutos",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromRGBO(102, 0, 161, 0.4)),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    //------------------fecha de reserva--------
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 15),
                      child: Row(
                        children: [
                          Icon(
                            Icons.today,
                            size: 30,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Viernes, 11 de septiembre de 2020",
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Hoy",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromRGBO(102, 0, 161, 0.4)),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    //---------------hora de incio de al cita
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 15),
                      child: Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 30,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "11:26",
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Hora de inicio",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromRGBO(102, 0, 161, 0.4)),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    //--------numero de telefono---
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 15),
                      child: Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.start,
                        spacing: 1.0,
                        runSpacing: 10,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15, right: 10),
                            child: Icon(
                              Icons.phone_android,
                              size: 30,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Column(
                              children: <Widget>[
                                InternationalPhoneInput(
                                  onPhoneNumberChange: onPhoneNumberChange,
                                  initialPhoneNumber: phoneNumber,
                                  initialSelection: phoneIsoCode,
                                  enabledCountries: ['+51'],
                                  labelText: "Celular",
                                ),
                                SizedBox(height: 20),
                                Visibility(
                                  child: Text(confirmedNumber),
                                  visible: visible,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    //--------Nombre del dueño---
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          prefixIcon: Icon(Icons.person_outline),
                          labelText: "Nombre dueño",
                          hintText: "Nombres sdueño",
                        ),
                      ),
                    ),

                    //---------correo-------
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          prefixIcon: Icon(Icons.email),
                          labelText: "Correo",
                          hintText: "Correo",
                        ),
                      ),
                    ),
                    //--------Nombre del dueño---
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          prefixIcon: Icon(Icons.pets),
                          labelText: "Nombre Mascota",
                          hintText: "Nombre Mascota",
                        ),
                      ),
                    ),
                    //-----------------escoger especie / cupos
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 20, right: 15),
                      child: Row(
                        children: [
                          //----------opcion de especies--------
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 5, right: 25),
                                child: Text("Nro. Mascotas:"),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: DropdownButton(
                                  iconEnabledColor:
                                      Theme.of(context).primaryColor,
                                  iconSize: 40,
                                  value: _value,
                                  items: [
                                    DropdownMenuItem(
                                      child: Text(
                                        'Canino',
                                      ),
                                      value: 0,
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Felino'),
                                      value: 1,
                                    ),
                                    DropdownMenuItem(
                                      child: Text('equino'),
                                      value: 2,
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Bovino'),
                                      value: 3,
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Aves'),
                                      value: 4,
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Porcino'),
                                      value: 5,
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Caprino'),
                                      value: 6,
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Ovino'),
                                      value: 7,
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _value = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          //----------escoger cantidad de cupos----
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 25, bottom: 5),
                                child: Text("Especie Mascota:"),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: DropdownButton(
                                  iconEnabledColor:
                                      Theme.of(context).primaryColor,
                                  iconSize: 40,
                                  value: _valor,
                                  items: [
                                    DropdownMenuItem(
                                      child: Text('1'),
                                      value: 0,
                                    ),
                                    DropdownMenuItem(
                                      child: Text('2'),
                                      value: 1,
                                    ),
                                    DropdownMenuItem(
                                      child: Text('3'),
                                      value: 2,
                                    ),
                                    DropdownMenuItem(
                                      child: Text('4'),
                                      value: 3,
                                    ),
                                    DropdownMenuItem(
                                      child: Text('5'),
                                      value: 4,
                                    ),
                                    DropdownMenuItem(
                                      child: Text('6'),
                                      value: 5,
                                    ),
                                    DropdownMenuItem(
                                      child: Text('6'),
                                      value: 6,
                                    ),
                                    DropdownMenuItem(
                                      child: Text('6'),
                                      value: 7,
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _value = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    //----------------------boton de enviar formulario--
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RaisedButton(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Color(0xFFED278A),
                          onPressed: () {},
                          child: Text('Siguiente',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
