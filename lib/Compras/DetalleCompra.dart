// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, library_private_types_in_public_api

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DetalleCompra extends StatefulWidget {
 final int idCompra;

 DetalleCompra({required this.idCompra});

 @override
 _CompraDetallePageState createState() => _CompraDetallePageState();
}

Future<List<dynamic>> fetchDetallesCompra(int idCompra) async {
 final response = await http.get(Uri.parse('https://localhost:7229/Compras/GetDetallesCompra?id=$idCompra'));

 if (response.statusCode == 200) {
  return jsonDecode(response.body) as List<dynamic>;
 } else {
  throw Exception('Failed to load detalles de compra: ${response.body}');
 }
}

Future<List<dynamic>> fetchCompra(int idCompra) async {
 final response = await http.get(Uri.parse('https://localhost:7229/Compras/CompraApi?id=$idCompra'));

 if (response.statusCode == 200) {
 return jsonDecode(response.body) as List<dynamic>;
 } else {
 throw Exception('Failed to load compra: ${response.body}');
 }
}

class _CompraDetallePageState extends State<DetalleCompra> {
  late Future<List<dynamic>> futureDetallesCompra;
  late Future<List<dynamic>> futureCompra;

  @override
  void initState() {
    super.initState();
    futureDetallesCompra = fetchDetallesCompra(widget.idCompra);
    futureCompra = fetchCompra(widget.idCompra);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              FutureBuilder<List<dynamic>>(
                future: futureCompra,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text('Detalles compra', textAlign: TextAlign.center, style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text('Total: \$${NumberFormat('#,##0', 'es_CO').format(snapshot.data![0]['total'] ?? 0)}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Poppins', color: Colors.black)),
                              SizedBox(height: 20),
                              Text('Fecha: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(snapshot.data![0]['fechaCompra'] ?? 'N/A'))}',textAlign: TextAlign.center,style: TextStyle(fontFamily: 'Poppins'),),                           
                              Text('Número de Factura: ${snapshot.data![0]['numeroFactura']}', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Poppins')),
                              Text('Proveedor: ${snapshot.data![0]['nomLocal']}', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Poppins',)),
                              Text('Empleado: ${snapshot.data![0]['idEmpleado']}', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Poppins')),
                              SizedBox(height: 20),
                              Text('Insumos comprados', textAlign: TextAlign.center, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'Poppins', color: Colors.black)),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  // By default, show a loading spinner.
                  return CircularProgressIndicator();
                },
              ),
              Expanded(
                child: FutureBuilder<List<dynamic>>(
                  future: futureDetallesCompra,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.fromLTRB(30.0, 2.0, 30.0, 2.0), // Agrega un espacio alrededor de cada tarjeta
                            child: Stack(
                              children: <Widget>[
                                Card(
                                  color: Color.fromRGBO(238, 248, 246, 1),
                                  elevation: 0,
                                  child: ListTile(
                                    leading: Icon(Icons.local_pizza, color: Color(0xFFFFC700)),
                                    title: Text(
                                      '${snapshot.data![index]['nomInsumo'] ?? 'N/A'}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600
                                      ),
                                    ),
                                    subtitle: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            '${snapshot.data![index]['cantidad'] ?? 'N/A'} ${snapshot.data![index]['medida'] ?? 'N/A'}',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // Aquí es donde usamos Positioned para mover el precio
                                Positioned(
                                  top: 22, // Ajusta este valor para mover el precio hacia arriba o hacia abajo
                                  right: 25,
                                  child: Text(
                                    '\$${NumberFormat('#,##0', 'es_CO').format(snapshot.data![index]['precioInsumo'] ?? 0)}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Poppins'
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }

                    // By default, show a loading spinner.
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ],
          ),
          Positioned(
            top: 15, // puedes ajustar estos valores según tus necesidades
        left: 15,
        child: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          iconSize: 40,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    ],
  ),
);
}
}
