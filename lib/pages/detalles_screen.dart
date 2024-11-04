import 'package:flutter/material.dart';

class DetallesScreen extends StatelessWidget {
  final String patente;
  final String modelo;
  final int precio;
  final String marca;

  const DetallesScreen({
    super.key,
    required this.patente,
    required this.modelo,
    required this.precio,
    required this.marca,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF003366),
        title: Text('Detalles del Auto', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Patente: $patente', style: TextStyle(fontSize: 20, color: Color(0xFF003366))),
              SizedBox(height: 10),
              Text('Modelo: $modelo', style: TextStyle(fontSize: 20, color: Color(0xFF003366))),
              SizedBox(height: 10),
              Text('Marca: $marca', style: TextStyle(fontSize: 20, color: Color(0xFF003366))),
              SizedBox(height: 10),
              Text('Precio: \$${precio.toString()}', style: TextStyle(fontSize: 20, color: Color(0xFF003366))),
            ],
          ),
        ),
      ),
    );
  }
}
