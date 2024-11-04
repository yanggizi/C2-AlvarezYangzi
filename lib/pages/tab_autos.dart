import 'package:flutter/material.dart';
import 'package:flutter_application_api_autos/pages/autos_agregar.dart';
import 'package:flutter_application_api_autos/pages/autos_editar.dart';
import 'package:flutter_application_api_autos/pages/detalles_screen.dart';
import 'package:flutter_application_api_autos/provider/autos_provider.dart';

class TabAutos extends StatefulWidget {
  const TabAutos({super.key});

  @override
  State<TabAutos> createState() => _TabAutosState();
}

class _TabAutosState extends State<TabAutos> {
  AutosProvider provider = AutosProvider();
  List<dynamic> autos = [];
  List<dynamic> marcas = [];

  @override
  void initState() {
    super.initState();
    cargarDatos();
  }

  Future<void> cargarDatos() async {
    List<dynamic> autosData = await provider.getAutos();
    List<dynamic> marcasData = await provider.getMarcas();
    setState(() {
      autos = autosData;
      marcas = marcasData;
    });
  }

  String obtenerNombreMarca(int marcaId) {
    final marca = marcas.firstWhere((marca) => marca['id'] == marcaId, orElse: () => null);
    return marca != null ? marca['nombre'] : 'Desconocida';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Detalle", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("Auto", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("Precio", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Expanded(
          child: autos.isEmpty || marcas.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.separated(
                  separatorBuilder: (_, __) => Divider(),
                  itemCount: autos.length,
                  itemBuilder: (context, index) {
                    final auto = autos[index];
                    final marcaNombre = obtenerNombreMarca(auto['marca_id']);
                    return ListTile(
                      leading: IconButton(
                        icon: Icon(Icons.search, color: Color(0xFF003366)), // Ícono de lupa
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetallesScreen(
                                patente: auto['patentes'],
                                modelo: auto['modelo'],
                                precio: auto['precio'],
                                marca: marcaNombre,
                              ),
                            ),
                          );
                        },
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              '${auto['modelo']}, $marcaNombre',
                              style: TextStyle(color: Color(0xFF003366)),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              '${auto['precio']}',
                              textAlign: TextAlign.right,
                              style: TextStyle(color: Color(0xFF003366)),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        MaterialPageRoute route = MaterialPageRoute(
                          builder: (context) => AutosEditar(
                            id: auto['id'],
                            patente: auto['patentes'],
                            modelo: auto['modelo'],
                            precio: auto['precio'],
                            marcaId: auto['marca_id'],
                          ),
                        );
                        Navigator.push(context, route).then((value) {
                          setState(() {});
                        });
                      },
                    );
                  },
                ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              MaterialPageRoute route = MaterialPageRoute(
                builder: (context) => AutosAgregar(),
              );
              Navigator.push(context, route).then((value) {
                if (value == true) { // Espera un valor `true` si el auto fue agregado exitosamente
                  cargarDatos(); // Vuelve a cargar los datos
                }
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow, // Fondo amarillo para el botón
              foregroundColor: Color(0xFF003366), // Texto en azul oscuro
            ),
            child: Text('Agregar Auto'),
          ),
        ),
      ],
    );
  }
}
