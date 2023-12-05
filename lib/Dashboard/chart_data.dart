// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'dart:math' as math;
import 'dart:convert';

Future<List<Map<String, dynamic>>> fetchDatagrafica() async {
  final response = await http.get(
      Uri.parse('http://pachos-001-site1.btempurl.com/estadisticas/ComprasyVentasA%C3%B1o'));
  if (response.statusCode == 200) {
    List<Map<String, dynamic>> data =
        List<Map<String, dynamic>>.from(json.decode(response.body));
    return data.map((item) {
      return {
        'month': item['month'],
        'totalVenta': item['totalVenta'],
        'totalCompra': item['totalCompra'],
      };
    }).toList();
  } else {
    throw Exception('Failed to load data');
  }
}

List<FlSpot> createData(List<Map<String, dynamic>> data, String key) {
  return data.map((item) {
    return FlSpot(item['month'].toDouble(),
        item[key] != null ? item[key].toDouble() : 0.0);
  }).toList();
}

LineChartBarData createChartData(List<FlSpot> data, Color color) {
  return LineChartBarData(
    spots: data,
    isCurved: false,
    color: color,
    barWidth: 2,
    isStrokeCapRound: true,
    dotData: FlDotData(show: true),
    belowBarData: BarAreaData(show: false),
  );
}

Widget drawChart(List<LineChartBarData> lines) {
  return LineChart(
    LineChartData(
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(show: false),
      borderData: FlBorderData(show: false),
      lineBarsData: lines,
    ),
  );
}

class grafica extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchDatagrafica(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            if (snapshot.data != null) {
              List<FlSpot> ventasData =
                  createData(snapshot.data!, 'totalVenta');
              List<FlSpot> comprasData =
                  createData(snapshot.data!, 'totalCompra');
              LineChartBarData ventasLine =
                  createChartData(ventasData, Color(0xFFFFC700));
              LineChartBarData comprasLine = createChartData(
                  comprasData, Color.fromARGB(255, 133, 207, 239));

              double maxValue =
                  ventasData.map((spot) => spot.y).reduce(math.max);
              double step = maxValue / 5;
              List<String> yTitles = List.generate(
                  5, (index) => (step * index).toStringAsFixed(0));
              yTitles.add((maxValue + 10000).toString());

              return LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      axisNameSize: 4.0,
                      sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: bottomTitleWidgets,
                          interval: 1.0),
                    ),
                    topTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                        getTitlesWidget: (valor, titulo) {
                          return Text(
                            yTitles[valor.toInt() % yTitles.length],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [ventasLine, comprasLine],
                ),
              );
            } else {
              return Text('No data');
            }
          }
        }
        return Center(
          child: Image.asset('img/pizza_loading.gif'),
        );
      },
    );
  }
}

//--Apertura ultimo codigo de la grafica--
Widget bottomTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );
  Widget text;
  switch (value.toInt()) {
    case 1:
      text = const Text('Ene', style: style);
      break;
    case 2:
      text = const Text('Feb', style: style);
      break;
    case 3:
      text = const Text('Mar', style: style);
      break;
    case 4:
      text = const Text('Abr', style: style);
      break;
    case 5:
      text = const Text('May', style: style);
      break;
    case 6:
      text = const Text('Jun', style: style);
      break;
    case 7:
      text = const Text('Jul', style: style);
      break;
    case 8:
      text = const Text('Ago', style: style);
      break;
    case 9:
      text = const Text('Sep', style: style);
      break;
    case 10:
      text = const Text('Oct', style: style);
      break;
    case 11:
      text = const Text('Nov', style: style);
      break;
    case 12:
      text = const Text('Dic', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: text,
  );
}
  //--Cierre de ultimo codigo de la grafica--