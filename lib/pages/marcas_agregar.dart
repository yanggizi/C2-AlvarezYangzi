import 'package:flutter/material.dart';
import 'package:flutter_application_api_autos/provider/autos_provider.dart';

class MarcasAgregar extends StatefulWidget {
  const MarcasAgregar({super.key});

  @override
  State<MarcasAgregar> createState() => _MarcasAgregarState();
}

class _MarcasAgregarState extends State<MarcasAgregar> {
  TextEditingController nombreCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF003366), // Azul oscuro
        title: Text(
          'Agregar Marca',
          style: TextStyle(color: Colors.white), // Texto en blanco
        ),
        iconTheme: IconThemeData(color: Colors.white), // Ícono de retroceso en blanco
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nombreCtrl,
              decoration: InputDecoration(
                labelText: 'Marca Autos',
                hintText: 'Nombre fabricante',
                labelStyle: TextStyle(color: Color(0xFF003366)), // Etiqueta en azul oscuro
                border: OutlineInputBorder(),
              ),
            ),
            Spacer(),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow, // Fondo amarillo
                  foregroundColor: Color(0xFF003366), // Texto en azul oscuro
                ),
                onPressed: () {
                  AutosProvider provider = AutosProvider();
                  provider.marcasAgregar(nombreCtrl.text);
                  Navigator.pop(context);
                },
                child: Text('Agregar Marca'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
