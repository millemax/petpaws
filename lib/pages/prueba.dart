import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Column(
              children: [
                //------------------container de cabecera---
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(102, 0, 161, 0.2),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Solicitar cita",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color(0xff572364)),
                        ),
                        Icon(
                          Icons.close,
                          color: Color(0xff572364),
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
                //--
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
                //--
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
                //--
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 15),
                  child: InternationalPhoneInput(
                    onPhoneNumberChange: onPhoneNumberChange,
                    initialPhoneNumber: phoneNumber,
                    initialSelection: phoneIsoCode,
                    enabledCountries: ['+233', '+1'],
                    labelText: "Phone Number",
                  ),
                ),
              ],
            ),
          ),
        ),
        /* Visibility(
              child: Text(confirmedNumber),
              visible: visible,
            ), */
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
