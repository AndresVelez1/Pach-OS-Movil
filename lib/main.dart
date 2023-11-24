// // ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'Login/screens/login_screen.dart';
// import 'Compras/Compras.dart'; // Importa el archivo Compras.dart

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title), // Cambia widget.title a title
//       ),
//       body: Center(
//         child: ElevatedButton(
//           child: Text('Ver Compras'),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => Compras()),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      routes: {
        'login': (_) => const LoginScreen(),
      },
      initialRoute: 'login',
    );
  }
}
