import 'package:flutter/material.dart';
import 'package:flutter_application_api_autos/pages/marcas_agregar.dart';
import 'package:flutter_application_api_autos/pages/marcas_editar.dart';
import 'package:flutter_application_api_autos/provider/autos_provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TabMarcas extends StatefulWidget {
  const TabMarcas({super.key});

  @override
  State<TabMarcas> createState() => _TabMarcasState();
}

class _TabMarcasState extends State<TabMarcas> {
  AutosProvider provider = AutosProvider();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder(
            future: provider.getMarcas(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.separated(
                separatorBuilder: (_, __) => Divider(),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    child: ListTile(
                      leading: Icon(Icons.car_repair, color: Color(0xFF003366)),
                      title: Text(
                        snapshot.data[index]['nombre'],
                        style: TextStyle(color: Color(0xFF003366)), // Texto en azul oscuro
                      ),
                    ),
                    startActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            MaterialPageRoute route = MaterialPageRoute(
                              builder: (context) => MarcasEditar(
                                id: snapshot.data[index]['id'],
                                nombre: snapshot.data[index]['nombre'],
                              ),
                            );
                            Navigator.push(context, route).then((value) {
                              setState(() {});
                            });
                          },
                          backgroundColor: Colors.purple,
                          icon: Icons.edit,
                          label: 'Editar',
                        ),
                      ],
                    ),
                    endActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            confirmDialog(context, snapshot.data[index]['nombre']).then((confirma) {
                              if (confirma) {
                                var nombre = snapshot.data[index]['id'];
                                setState(() {
                                  provider.marcasBorrar(snapshot.data[index]['id']).then((borradoExitoso) {
                                    if (!borradoExitoso) {
                                      showSnackBar('Ha ocurrido un problema');
                                    } else {
                                      showSnackBar('Marca $nombre borrada');
                                      snapshot.data.removeAt(index);
                                    }
                                  });
                                });
                              }
                            });
                          },
                          backgroundColor: Colors.red,
                          icon: Icons.delete,
                          label: 'Borrar',
                        ),
                      ],
                    ),
                  );
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
                builder: (context) => MarcasAgregar(),
              );
              Navigator.push(context, route).then(
                (value) => setState(() {}),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow, // Fondo amarillo para el botón
              foregroundColor: Color(0xFF003366), // Texto en azul oscuro
            ),
            child: Text('Agregar Marca'),
          ),
        ),
      ],
    );
  }

  Future<dynamic> confirmDialog(BuildContext context, String marca) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirmar borrado', style: TextStyle(color: Color(0xFF003366))),
          content: Text('¿Borrar la marca $marca?', style: TextStyle(color: Color(0xFF003366))),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('CANCELAR', style: TextStyle(color: Color(0xFF003366))),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow, // Fondo amarillo
                foregroundColor: Color(0xFF003366), // Texto azul oscuro
              ),
              child: Text('ACEPTAR'),
            ),
          ],
        );
      },
    );
  }

  void showSnackBar(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text(mensaje),
      ),
    );
  }
}
