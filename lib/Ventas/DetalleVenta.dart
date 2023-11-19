// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, library_private_types_in_public_api

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DetalleVenta extends StatefulWidget {
  final int idVenta;

  DetalleVenta({required this.idVenta});

  @override
  _CompraDetallePageState createState() => _CompraDetallePageState();
}

Future<List<dynamic>> fetchDetallesCompra(int idVenta) async {
  final response = await http.get(Uri.parse(
      'https://localhost:7229/Ventas/GetDetallesVenta?idVenta=$idVenta'));

  if (response.statusCode == 200) {
    return jsonDecode(response.body) as List<dynamic>;
  } else {
    throw Exception('Failed to load detalles de venta: ${response.body}');
  }
}

Future<List<dynamic>> fetchCompra(int idVenta) async {
  final response = await http
      .get(Uri.parse('https://localhost:7229/Ventas/VentaApi?id=$idVenta'));

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse is List) {
      return jsonResponse.cast<dynamic>();
    } else if (jsonResponse is Map) {
      return [jsonResponse];
    } else {
      throw Exception('Unexpected response type: ${jsonResponse.runtimeType}');
    }
  } else {
    throw Exception('Failed to load venta: ${response.body}');
  }
}

class _CompraDetallePageState extends State<DetalleVenta> {
  late Future<List<dynamic>> futureDetallesCompra;
  late Future<List<dynamic>> futureCompra;

  @override
  void initState() {
    super.initState();
    futureDetallesCompra = fetchDetallesCompra(widget.idVenta);
    futureCompra = fetchCompra(widget.idVenta);
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
                          title: Text('Detalles venta',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins')),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                  'Total: \$${NumberFormat('#,##0', 'es_CO').format(snapshot.data![0]['totalVenta'] ?? 0)}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins',
                                      color: Colors.black)),
                              SizedBox(height: 20),
                              Text(
                                'Fecha: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(snapshot.data![0]['fechaVenta'] ?? 'N/A'))}',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontFamily: 'Poppins'),
                              ),
                              Text(
                                  'N° de venta: ${snapshot.data![0]['idVenta']}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontFamily: 'Poppins')),
                              Text(
                                  'Metodo de pago: ${snapshot.data![0]['tipoPago']}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                  )),
                              Text(
                                  'Empleado: ${snapshot.data![0]['idEmpleado']}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontFamily: 'Poppins')),
                              SizedBox(height: 20),
                              Text('Productos vendidos',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins',
                                      color: Colors.black)),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  return Center(
                    child: Image.asset('img/pizza_loading.gif'),
                  );
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
                            padding: EdgeInsets.fromLTRB(30.0, 2.0, 30.0, 2.0),
                            child: Stack(
                              children: <Widget>[
                                Card(
                                  color: Color.fromRGBO(238, 248, 246, 1),
                                  elevation: 0,
                                  child: ListTile(
                                    leading: Icon(Icons.local_pizza,
                                        color: Color(0xFFFFC700)),
                                    title: Text(
                                      '${snapshot.data![index]['nomProducto'] ?? 'N/A'}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600),
                                    ),
                                    subtitle: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            '${snapshot.data![index]['cantVendida'] ?? 'N/A'}',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 22,
                                  right: 25,
                                  child: Text(
                                    '\$${NumberFormat('#,##0', 'es_CO').format(snapshot.data![index]['precio'] ?? 0)}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Poppins'),
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

                    return Center(
                      child: Image.asset('img/pizza_loading.gif'),
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            top: 15,
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
