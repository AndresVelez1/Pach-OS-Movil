// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pach_os_movil/Compras/Compras.dart';
import 'package:pach_os_movil/Ventas/Ventas.dart';
import 'package:pach_os_movil/main.dart';

import 'chart_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Dashboard extends StatelessWidget {
  Future<Map<String, dynamic>> fetchData(String apiUrl) async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return Map<String, dynamic>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data from API: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double
              .infinity, // Esto hace que el contenedor ocupe todo el ancho disponible
          height: 200.0, // Define un tamaño para el contenedor
          child: Stack(
            alignment: Alignment.centerRight,
            children: <Widget>[
              Positioned(
                top:
                    20.0, // Ajusta este valor para mover la imagen hacia arriba o hacia abajo
                right:
                    100, // Ajusta este valor para mover la imagen hacia la izquierda o hacia la derecha
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(150.0),
                  child: SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.asset('img/pizza.jpg'),
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color(0xFFFFC700),
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
                    child: Image.asset('img/descargar.jpg'),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Título "Informes"
            SizedBox(height: 10),
            Text(
              'Informes',
              style: TextStyle(
                fontSize: 55,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 10),
            // Subtítulo "Información general del negocio"
            Text(
              'Información general del negocio',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins'),
            ),
            SizedBox(height: 16),
            // Primer bloque con las primeras cuatro cartas
            GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              shrinkWrap: true,
              children: [
                // Card 1 - Total de Ventas
                buildCard(
                  title: 'Ventas',
                  apiEndpoint:
                      'http://pachos-001-site1.btempurl.com/Estadisticas/VentasdelMes',
                  columnKey: 'totalVentas',
                  formatValue: true,
                ),
                // Card 2 - Total de Compras
                buildCard(
                  title: 'Compras',
                  apiEndpoint:
                      'http://pachos-001-site1.btempurl.com/Estadisticas/ComprasdelMes',
                  columnKey: 'totalCompras',
                  formatValue: true,
                ),
                // Card 3 - Total de Ventas en Efectivo
                buildCardWithFilter(
                  title: 'Efectivo',
                  apiEndpoint:
                      'http://pachos-001-site1.btempurl.com/Estadisticas/VentasdelMes',
                  columnKey: 'totalVentasEfectivo',
                  formatValue: true,
                ),
                // Card 4 - Total de Ventas en Transferencia
                buildCardWithFilter(
                  title: 'Transferencia',
                  apiEndpoint:
                      'http://pachos-001-site1.btempurl.com/Estadisticas/VentasdelMes',
                  columnKey: 'totalVentasTransferencia',
                  formatValue: true,
                ),
              ],
            ),
            SizedBox(height: 16),
            // Segundo bloque con la quinta carta
            Container(
              alignment: Alignment.center,
              child: buildDifferenceCard(
                apiVentas:
                    'http://pachos-001-site1.btempurl.com/Estadisticas/ComprasdelMes',
                columnKeyDiferencia: 'diferencia',
                formatValue: true,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Productos mas vendidos',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),

            SizedBox(height: 16),

            FutureBuilder<List<Map<String, dynamic>>>(
              future: fetchProductData(
                  'http://pachos-001-site1.btempurl.com/Estadisticas/ProductosMasVendidosMes'),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final products = snapshot.data;

                    // Find the maximum total sold
                    final maxTotalSold = products!
                        .map<int>(
                            (product) => product['totalVendido'] as int ?? 0)
                        .reduce(max);

                    // Calculate 110% of the maximum total sold to set as the new maximum value for progress
                    final adjustedMaxValue = maxTotalSold * 1.1;

                    return Column(
                      children: products!.map<Widget>((product) {
                        final productName = product['producto'] as String ?? '';
                        final soldQuantity =
                            product['cantidadVendida'] as int ?? 0;
                        final totalSold = product['totalVendido'] as int ?? 0;

                        // Adjust the progress to be in the range [0, 1] based on the adjustedMaxValue
                        final progress = totalSold / adjustedMaxValue;

                        return Container(
                          color: Color(0xFFEEF8F6),
                          margin: EdgeInsets.only(bottom: 8),
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: productName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Color.fromARGB(255, 1, 1, 1),
                                    fontFamily: 'Poppins',
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: ' (${soldQuantity.toString()})',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 1, 1, 1),
                                        fontSize: 17,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              LinearProgressIndicator(
                                value: progress,
                                color: Color.fromRGBO(255, 199, 0, 1),
                                backgroundColor: Colors.grey[200],
                              ),
                              Text(
                                'Total vendido: ${formatCurrency(totalSold)}',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 1, 1, 1),
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  }
                }
                return Center(
                  child: Image.asset('img/pizza_loading.gif'),
                );
              },
            ),

            // Bloque con la gráfica de líneas
            SizedBox(height: 10),
            Text(
              'Información ventas y compras del año',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    color: Color(0xFFFFC700), // Color para ventas
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Ventas',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 20),
                  Container(
                    width: 20,
                    height: 20,
                    color: Color.fromARGB(
                        255, 133, 207, 239), // Color para compras
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Compras',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 350,
              width: double.infinity,
              child: grafica(),
            ),
            SizedBox(
              height: 16,
            ),
//--Cierre para el segundo codigo de la grafica--
          ],
        ),
      ),
    );
  }

  // Método para construir las cartas básicas
  Widget buildCard({
    required String title,
    required String apiEndpoint,
    required String columnKey,
    required bool formatValue,
  }) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchData(apiEndpoint),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final data = snapshot.data;
            final total = calculateTotal(data, columnKey);
            final formattedTotal =
                formatValue ? formatCurrency(total) : total.toString();

            return Card(
              color: Color(0xFFEEF8F6),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment
                      .end, // Alinea el título en la parte inferior
                  children: [
                    Expanded(
                      child:
                          SizedBox(), // Espacio para que el contenido esté en la parte superior
                    ),
                    Text(
                      formattedTotal,
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Poppins',
                      ), // Tamaño de fuente más grande
                    ),
                    SizedBox(height: 8),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                      ), // Tamaño de fuente más pequeño para el título
                    ),
                  ],
                ),
              ),
            );
          }
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return Center(
          child: Image.asset('img/pizza_loading.gif'),
        );
      },
    );
  }

  Future<List<Map<String, dynamic>>> fetchProductData(String apiUrl) async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load product data from API: ${response.body}');
    }
  }

// Método para formatear un valor numérico como moneda
  String formatCurrency(int value) {
    final currencyFormatter = NumberFormat('#,##0', 'es_CO');
    return '\$${currencyFormatter.format(value)}';
  }

  // Método para construir las cartas con filtro

  Widget buildCardWithFilter({
    required String title,
    required String apiEndpoint,
    required String columnKey,
    required bool formatValue,
  }) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchData(apiEndpoint),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final data = snapshot.data;
            final total = calculateFilteredTotal(data, columnKey);
            final formattedTotal =
                formatValue ? formatCurrency(total) : total.toString();

            return Card(
              color: Color(0xFFEEF8F6),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: SizedBox(),
                    ),
                    Text(
                      formattedTotal,
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }
        return Center(
          child: Image.asset('img/pizza_loading.gif'),
        );
      },
    );
  }

  // Método para construir la carta de diferencia
  Widget buildDifferenceCard({
    required String apiVentas,
    required String columnKeyDiferencia,
    required bool formatValue,
  }) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchData(apiVentas),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final data = snapshot.data;

            final difference = data?[columnKeyDiferencia] as int? ?? 0;
            final formattedDifference = formatValue
                ? formatCurrency(difference)
                : difference.toString();

            return Card(
              color: Color(0xFFEEF8F6),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      formattedDifference,
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Diferencia entre Ventas y Compras',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return Center(
          child: Image.asset('img/pizza_loading.gif'),
        );
      },
    );
  }

  int calculateTotal(Map<String, dynamic>? data, String columnKey) {
    if (data == null) return 0;
    return data[columnKey] as int? ?? 0;
  }

  int calculateFilteredTotal(
    Map<String, dynamic>? data,
    String columnKey,
  ) {
    if (data == null) return 0;

    final int? filteredTotal = data[columnKey] as int?;
    return filteredTotal ?? 0;
  }
}
