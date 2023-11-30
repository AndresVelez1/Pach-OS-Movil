// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pach_os_movil/Compras/Compras.dart';
import 'package:pach_os_movil/Ventas/Ventas.dart';
import 'package:pach_os_movil/main.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class Dashboard extends StatelessWidget {
  Future<List<Map<String, dynamic>>> fetchData(String apiUrl) async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data from API: ${response.body}');
    }
  }

  Future<List<FlSpot>> fetchChartData(
      String apiUrl, String dateKey, String valueKey) async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode != 200) {
      throw Exception('Failed to load data from API: ${response.body}');
    }

    final List data = jsonDecode(response.body);

    final uniqueDates = Set<String>();
    final spots = data
        .where((entry) =>
            entry[valueKey] is num && !(entry[valueKey] as num).isNaN)
        .map<FlSpot>((entry) {
      final date = DateTime.parse(entry[dateKey]);
      final formattedDate = '${date.year}-${date.month}';

      uniqueDates.add(formattedDate);
      return FlSpot(date.month.toDouble(), entry[valueKey].toDouble());
    }).toList();

    return spots;
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
                  columnKey: 'totalVenta',
                  formatValue: true,
                ),
                // Card 2 - Total de Compras
                buildCard(
                  title: 'Compras',
                  apiEndpoint:
                      'http://pachos-001-site1.btempurl.com/Estadisticas/ComprasdelMes',
                  columnKey: 'total',
                  formatValue: true,
                ),
                // Card 3 - Total de Ventas en Efectivo
                buildCardWithFilter(
                  title: 'Efectivo',
                  apiEndpoint:
                      'http://pachos-001-site1.btempurl.com/Estadisticas/VentasdelMes',
                  columnKey: 'totalVenta',
                  filterValue: 'Efectivo',
                  formatValue: true,
                ),
                // Card 4 - Total de Ventas en Transferencia
                buildCardWithFilter(
                  title: 'Transferencia',
                  apiEndpoint:
                      'http://pachos-001-site1.btempurl.com/Estadisticas/VentasdelMes',
                  columnKey: 'totalVenta',
                  filterValue: 'Transferencia',
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
                    'http://pachos-001-site1.btempurl.com/Estadisticas/VentasdelMes',
                apiCompras:
                    'http://pachos-001-site1.btempurl.com/Estadisticas/ComprasdelMes',
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
                                  fontFamily: 'Poppins',
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ' (${soldQuantity.toString()})',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
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
              },
            ),

            SizedBox(height: 16),
            // Bloque con la gráfica de líneas
            FutureBuilder<List<FlSpot>>(
              future: fetchChartData(
                'http://pachos-001-site1.btempurl.com/Estadisticas/VentasAño',
                'fechaVenta',
                'totalVenta',
              ),
              builder: (context, snapshotVentas) {
                if (snapshotVentas.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshotVentas.hasError) {
                  return Text('Error en ventas: ${snapshotVentas.error}');
                } else {
                  final ventasData = snapshotVentas.data;
                  print("Data ventas: $ventasData");

                  if (ventasData != null && ventasData.isNotEmpty) {
                    // Asegúrate de que la lista de datos no esté vacía
                    return buildLineChart(ventasData, Colors.red);
                  } else {
                    return Text('No hay datos de ventas disponibles.');
                  }
                }
              },
            ),
            // ...
            FutureBuilder<List<FlSpot>>(
              future: fetchChartData(
                'http://pachos-001-site1.btempurl.com/Estadisticas/ComprasAño',
                'fechaCompra',
                'total',
              ),
              builder: (context, snapshotCompras) {
                if (snapshotCompras.connectionState ==
                    ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshotCompras.hasError) {
                  return Text('Error en compras: ${snapshotCompras.error}');
                } else {
                  final comprasData = snapshotCompras.data;
                  print("Data compras: $comprasData");

                  return buildLineChart(comprasData, Colors.blue);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLineChart(List<FlSpot>? data, Color color) {
    if (data == null || data.isEmpty) {
      print("Data received: $data");

      // Puedes manejar esto de una manera específica si es necesario
      return SizedBox.shrink();
    }

    return SizedBox(
      width: double.infinity,
      height: 200,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: const Color(0xff37434d),
                strokeWidth: 1,
              );
            },
            getDrawingVerticalLine: (value) {
              return FlLine(
                color: const Color(0xff37434d),
                strokeWidth: 1,
              );
            },
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: SideTitles(
              showTitles: true,
              reservedSize: 22,
              getTextStyles: (context, value) => const TextStyle(
                color: Color(0xff68737d),
                fontWeight: FontWeight.bold,
                fontSize: 16,
                fontFamily: 'Poppins',
              ),
              getTitles: (value) {
                // Convertir el valor a un entero y mostrarlo
                final month = value.toInt();
                return month.toString();
              },
              margin: 8,
            ),
            leftTitles: SideTitles(
              showTitles: true,
              getTextStyles: (context, value) => const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                fontFamily: 'Poppins',
              ),
              getTitles: (value) {
                // Puedes personalizar las etiquetas del eje Y aquí según tu necesidad
                return value.toString();
              },
              reservedSize: 28,
              margin: 12,
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: const Color(0xff37434d), width: 1),
          ),
          minX: data.first.x,
          maxX: data.last.x,
          minY: data
              .map((spot) => spot.y)
              .reduce((min, value) => min > value ? value : min),
          maxY: data
              .map((spot) => spot.y)
              .reduce((max, value) => max < value ? value : max),
          lineBarsData: [
            LineChartBarData(
              spots: data,
              isCurved: true,
              colors: [color],
              barWidth: 4,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: false,
              ),
              belowBarData: BarAreaData(
                show: true,
                colors: [color.withOpacity(0.3)],
              ),
            ),
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
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchData(apiEndpoint),
      builder: (context, snapshot) {
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
    required String filterValue,
    required bool formatValue,
  }) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchData(apiEndpoint),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final data = snapshot.data;
          final total = calculateFilteredTotal(data, columnKey, filterValue);
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
      },
    );
  }

  // Método para construir la carta de diferencia
  Widget buildDifferenceCard(
      {required String apiVentas,
      required String apiCompras,
      required bool formatValue}) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchData(apiVentas),
      builder: (context, snapshotVentas) {
        if (snapshotVentas.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshotVentas.hasError) {
          return Text('Error: ${snapshotVentas.error}');
        } else {
          final ventasData = snapshotVentas.data;
          final totalVentas = calculateTotal(ventasData, 'totalVenta');
          return FutureBuilder<List<Map<String, dynamic>>>(
            future: fetchData(apiCompras),
            builder: (context, snapshotCompras) {
              if (snapshotCompras.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshotCompras.hasError) {
                return Text('Error: ${snapshotCompras.error}');
              } else {
                final comprasData = snapshotCompras.data;
                final totalCompras = calculateTotal(comprasData, 'total');
                final difference = totalVentas - totalCompras;
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
                          ), // Adjusted font size
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Diferencia entre Ventas y Compras',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                          ), // Adjusted font size
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          );
        }
      },
    );
  }

  int calculateTotal(List<Map<String, dynamic>>? data, String columnKey) {
    if (data == null) return 0;
    return data
        .map<int>((entry) => entry[columnKey] as int? ?? 0)
        .reduce((a, b) => a + b);
  }

  int calculateFilteredTotal(
      List<Map<String, dynamic>>? data, String columnKey, String filterValue) {
    if (data == null) return 0;
    return data
        .where((entry) => entry['tipoPago'] == filterValue)
        .map<int>((entry) => entry[columnKey] as int? ?? 0)
        .reduce((a, b) => a + b);
  }
}
