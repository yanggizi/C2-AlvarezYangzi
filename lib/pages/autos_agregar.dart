import 'package:flutter/material.dart';
import 'package:flutter_application_api_autos/provider/autos_provider.dart';

class AutosAgregar extends StatefulWidget {
  const AutosAgregar({super.key});

  @override
  State<AutosAgregar> createState() => _AutosAgregarState();
}

class _AutosAgregarState extends State<AutosAgregar> {
  TextEditingController patenteCtrl = TextEditingController();
  TextEditingController modeloCtrl = TextEditingController();
  TextEditingController precioCtrl = TextEditingController();

  List<dynamic> marcas = [];
  int? marcaSeleccionada; // Almacena el ID de la marca seleccionada como int

  @override
  void initState() {
    super.initState();
    cargarMarcas();
  }

  Future<void> cargarMarcas() async {
    AutosProvider provider = AutosProvider();
    List<dynamic> marcasData = await provider.getMarcas();
    setState(() {
      marcas = marcasData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF003366), // Azul oscuro
        title: Text(
          'Agregar Auto',
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
            DropdownButtonFormField<int>(
              value: marcaSeleccionada,
              items: marcas.map<DropdownMenuItem<int>>((marca) {
                return DropdownMenuItem<int>(
                  value: marca['id'], // Guarda el ID de la marca como int
                  child: Text(marca['nombre']),
                );
              }).toList(),
              onChanged: (int? newValue) {
                setState(() {
                  marcaSeleccionada = newValue; // Almacena el ID de la marca seleccionada
                });
              },
              decoration: InputDecoration(
                labelText: 'Marca',
                labelStyle: TextStyle(color: Color(0xFF003366)),
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
                  if (marcaSeleccionada != null) {
                    AutosProvider provider = AutosProvider();
                    try {
                      await provider.autosAgregar(
                        patenteCtrl.text,
                        modeloCtrl.text,
                        int.parse(precioCtrl.text),
                        marcaSeleccionada!, // Se asegura de que marcaSeleccionada sea int
                      );
                      Navigator.pop(context, true); // Devuelve `true` si el auto fue agregado exitosamente
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Error al agregar el auto.\n'
                            'Patente: ${patenteCtrl.text}, '
                            'Modelo: ${modeloCtrl.text}, '
                            'Precio: ${precioCtrl.text}, '
                            'Marca ID: ${marcaSeleccionada.toString()}',
                          ),
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Por favor, selecciona una marca'),
                      ),
                    );
                  }
                },
                child: Text('Agregar Auto'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
