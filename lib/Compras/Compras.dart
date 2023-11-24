// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, use_key_in_widget_constructors, library_private_types_in_public_api, file_names, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'DetalleCompra.dart';
import 'package:intl/intl.dart';
import 'package:pach_os_movil/Dashboard/Dashboard.dart';
import 'package:pach_os_movil/Ventas/Ventas.dart';
import 'package:pach_os_movil/main.dart';

class Compras extends StatefulWidget {
  @override
  _ComprasState createState() => _ComprasState();
}

Future<List<dynamic>> fetchCompras() async {
  final response = await http.get(Uri.parse(
      'http://pachos-001-site1.btempurl.com/Compras/GetCompras'));

  if (response.statusCode == 200) {
    return jsonDecode(response.body) as List<dynamic>;
  } else {
    throw Exception('Failed to load compras: ${response.body}');
  }
}

class _ComprasState extends State<Compras> {
  late Future<List<dynamic>> futureCompras;
  late Future<List<dynamic>> futureComprasFiltered;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureCompras = fetchCompras();
    futureComprasFiltered =
        futureCompras; // Inicializar futureComprasFiltered con futureCompras
    searchController.addListener(() {
      setState(() {
        futureComprasFiltered = filterCompras(searchController.text);
      });
    });
  }

  @override
  void dispose() {
    // Limpiar el controlador cuando ya no se necesita
    searchController.dispose();
    super.dispose();
  }

  Future<List<dynamic>> filterCompras(String query) async {
    List<dynamic> allCompras = await futureCompras;
    return allCompras
        .where((compra) =>
            compra['nomLocal']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            compra['numeroFactura']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            compra['fechaCompra']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            compra['total']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            compra['idEmpleado']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: Text(''),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.black,
          width: MediaQuery.of(context).size.width / 2,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(150.0),
                  child: SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.network('img/descargar.jfif'),
                  ),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 20.0, left: 10),
                        child: Icon(
                          Icons.insert_chart,
                          color: Color.fromRGBO(255, 199, 0, 1),
                          size: 35,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Dashboard',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Dashboard()),
                  );
                },
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 30.0, left: 10),
                        child: Icon(
                          Icons.local_pizza,
                          color: Color.fromRGBO(255, 199, 0, 1),
                          size: 35,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Compras',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Compras()),
                  );
                },
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 45, left: 10),
                        child: Icon(
                          Icons.monetization_on,
                          color: Color.fromRGBO(255, 199, 0, 1),
                          size: 35,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Ventas',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Ventas()),
                  );
                },
              ),
              Expanded(
                child: Container(),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 2, left: 80),
                        child: Icon(
                          Icons.exit_to_app,
                          color: Color.fromRGBO(255, 199, 0, 1),
                          size: 35,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Salir',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: futureComprasFiltered,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    Center(
                      child: Text(
                        'Compras',
                        style: TextStyle(
                            fontSize: 55,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins'),
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Text(
                        'Listado de compras realizadas',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins'),
                      ),
                    ),
                    SizedBox(height: 40),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      width: 450,
                      child: TextField(
                        controller: searchController,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          hintText: 'Buscar...',
                          contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                color: const Color.fromARGB(255, 234, 229, 229),
                                width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(255, 199, 0, 1),
                                width: 2),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
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
                                    leading: Icon(Icons.shopping_cart,
                                        color: Color(0xFFFFC700)),
                                    title: Text(
                                      snapshot.data![index]['nomLocal']
                                              ?.toString() ??
                                          'N/A',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600),
                                    ),
                                    subtitle: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                snapshot.data![index]
                                                            ['numeroFactura']
                                                        ?.toString() ??
                                                    'N/A',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                    fontFamily: 'Poppins',
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              Text(
                                                DateFormat('dd/MM/yyyy').format(
                                                        DateTime.parse(snapshot
                                                                        .data![
                                                                    index][
                                                                'fechaCompra'] ??
                                                            'N/A')) +
                                                    ' - ${snapshot.data![index]['idEmpleado'] ?? 'N/A'}',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                    fontFamily: 'Poppins',
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetalleCompra(
                                              idCompra: snapshot.data![index]
                                                  ['idCompra']),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Positioned(
                                  top: 29,
                                  right: 25,
                                  child: Text(
                                    '\$${NumberFormat('#,##0', 'es_CO').format(snapshot.data![index]['total'] ?? 0)}',
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
                      ),
                    ),
                  ],
                ));
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return Center(
            child: Image.asset('img/pizza_loading.gif'),
          );
        },
      ),
    );
  }
}
