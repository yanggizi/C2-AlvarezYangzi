import 'package:flutter/material.dart';
import 'package:flutter_application_api_autos/provider/autos_provider.dart';

class AutosEditar extends StatefulWidget {
  final int id;
  final String patente;
  final String modelo;
  final int precio;
  final int marcaId;

  const AutosEditar({
    super.key,
    required this.id,
    required this.patente,
    required this.modelo,
    required this.precio,
    required this.marcaId,
  });

  @override
  State<AutosEditar> createState() => _AutosEditarState();
}

class _AutosEditarState extends State<AutosEditar> {
  TextEditingController patenteCtrl = TextEditingController();
  TextEditingController modeloCtrl = TextEditingController();
  TextEditingController precioCtrl = TextEditingController();
  TextEditingController marcaIdCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    patenteCtrl.text = widget.patente;
    modeloCtrl.text = widget.modelo;
    precioCtrl.text = widget.precio.toString();
    marcaIdCtrl.text = widget.marcaId.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF003366), // Azul oscuro
        title: Text(
          'Editar Auto',
          style: TextStyle(color: Colors.white), // Texto en blanco
        ),
        iconTheme: IconThemeData(color: Colors.white), // Ícono de retroceso en blanco
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: patenteCtrl,
              decoration: InputDecoration(
                labelText: 'Patente',
                hintText: 'Ej. ABC123',
                labelStyle: TextStyle(color: Color(0xFF003366)),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: modeloCtrl,
              decoration: InputDecoration(
                labelText: 'Modelo',
                hintText: 'Ej. Corolla',
                labelStyle: TextStyle(color: Color(0xFF003366)),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: precioCtrl,
              decoration: InputDecoration(
                labelText: 'Precio',
                hintText: 'Ej. 20000',
                labelStyle: TextStyle(color: Color(0xFF003366)),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              controller: marcaIdCtrl,
              decoration: InputDecoration(
                labelText: 'ID de Marca',
                hintText: 'Ej. 1',
                labelStyle: TextStyle(color: Color(0xFF003366)),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
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
                  provider.autosEditar(
                    widget.id,
                    patenteCtrl.text,
                    modeloCtrl.text,
                    int.parse(precioCtrl.text),
                    int.parse(marcaIdCtrl.text),
                  );
                  Navigator.pop(context);
                },
                child: Text('Editar Auto'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
