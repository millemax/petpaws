import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:petpaws/page_administrador/crearVeterinaria.dart';
import 'package:petpaws/page_administrador/usuariosPage.dart';
import 'package:petpaws/page_administrador/veterinariasPage.dart';

class MenuAdministrador extends StatefulWidget {
  MenuAdministrador({Key key}) : super(key: key);

  @override
  _MenuAdministradorState createState() => _MenuAdministradorState();
}

class _MenuAdministradorState extends State<MenuAdministrador> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Administrador')
      ),
      body: Container(
        child: _getPage(currentPage),
      ),

      bottomNavigationBar: FancyBottomNavigation(
        barBackgroundColor: Colors.grey[300],
        tabs: [
        TabData(iconData: Icons.store, title: "Veterinarias"),
        TabData(iconData: Icons.add_box, title: "Crear veterinaria"),
        TabData(iconData: Icons.supervised_user_circle, title: "Usuarios")
        ],  
        initialSelection: 0,      

        onTabChangedListener: (position){
            setState(() {
            currentPage = position;

            });
        }
        
        ),      
      );
    
  }

//funcion para navegar entre las distintas paginas
  _getPage(int currentPage) {
    switch (currentPage) {
      case 0:
        return Container(child: VeterinariasList());

        break;

      case 1:
        return CrearVeterinaria();
           
        

        break;

      case 2:
        return Container(
          child: UsuriosList(),
        );

        break;
      default:
    }
  }
}
