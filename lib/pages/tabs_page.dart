import 'package:flutter/material.dart';
import 'package:flutter_application_api_autos/pages/tab_autos.dart';
import 'package:flutter_application_api_autos/pages/tab_marcas.dart';
import 'package:flutter_application_api_autos/pages/info_screen.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF003366), // Azul oscuro para la AppBar
          title: Text(
            'API AUTOS',
            style: TextStyle(color: Colors.white), // Texto blanco para visibilidad
          ),
          iconTheme: IconThemeData(color: Colors.white), // Iconos en blanco
          bottom: TabBar(
            indicatorColor: Colors.yellow, // Indicador de tab color amarillo
            labelColor: Colors.yellow, // Color de texto seleccionado
            unselectedLabelColor: Colors.white, // Color de texto no seleccionado
            tabs: [
              Tab(text: 'Marcas'),
              Tab(text: 'Autos'),
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF003366), // Azul oscuro para el DrawerHeader
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/Logo_UTFSM.jpeg',
                    height: 150,
                    width: 150,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home, color: Color(0xFF003366)),
                title: Text('Inicio', style: TextStyle(color: Color(0xFF003366))),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.info, color: Color(0xFF003366)),
                title: Text('Acerca de', style: TextStyle(color: Color(0xFF003366))),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InfoScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.settings, color: Color(0xFF003366)),
                title: Text('Configuración', style: TextStyle(color: Color(0xFF003366))),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TabMarcas(),
            TabAutos(),
          ],
        ),
      ),
    );
  }
}
