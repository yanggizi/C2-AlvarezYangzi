import 'package:flutter/material.dart';
import 'package:flutter_application_api_autos/provider/autos_provider.dart';

class MarcasEditar extends StatefulWidget {
  final int id;
  final String nombre;
  const MarcasEditar({super.key, this.id = 0, this.nombre = ''});

  @override
  State<MarcasEditar> createState() => _MarcasEditarState();
}

class _MarcasEditarState extends State<MarcasEditar> {
  TextEditingController nombreCtrl = TextEditingController();
  String textoError = '';

  @override
  void initState() {
    super.initState();
    nombreCtrl.text = widget.nombre;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF003366), // Azul oscuro
        title: Text(
          'Editar Marca',
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
                labelText: 'Marca Auto',
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
                onPressed: () async {
                  AutosProvider provider = AutosProvider();
                  var respuesta = await provider.marcasEditar(widget.id, nombreCtrl.text);
                  Navigator.pop(context);
                },
                child: Text('Editar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
