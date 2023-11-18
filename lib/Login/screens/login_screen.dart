import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _handleLogin() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    final response = await http.post(
      Uri.parse('https://localhost:7229/api/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      print('Mensaje: ${jsonResponse['Message']}');
      print('Datos del usuario: ${jsonResponse['User']}');
    } else {
      print('Error de inicio de sesión: ${response.statusCode}');
      print('Mensaje: ${jsonDecode(response.body)['Message']}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            CajaDeColor(size),
            IconoPersona(),
            LoginForm(context),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView LoginForm(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 350),
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 15,
                  offset: Offset(0, 5),
                )
              ],
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text('Inicio De Sesión ',
                    style: Theme.of(context).textTheme.headline4),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            hintText: 'ejemplo@gmail.com',
                            labelText: 'Correo Electronico',
                            icon: Icon(Icons.alternate_email_rounded),
                          ),
                          validator: (value) {
                            String pattern =
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regExp = new RegExp(pattern);
                            return regExp.hasMatch(value ?? '')
                                ? null
                                : 'el valor ingresado no es un correo';
                          },
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: _passwordController,
                          autocorrect: false,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: '**********',
                            labelText: 'Contraseña',
                            icon: Icon(Icons.lock_outline),
                          ),
                          validator: (value) {
                            return (value != null && value.length >= 6)
                                ? null
                                : 'la Contraseña debe ser mayor o igual a 6 digitos';
                          },
                        ),
                        const SizedBox(height: 30),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          disabledColor: Colors.grey,
                          color: Color(0xFFFFC700),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 80, vertical: 15),
                            child: const Text(
                              'Ingresar',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          onPressed: () {
                            _handleLogin(); // Llama al método para iniciar sesión
                          },
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  SafeArea IconoPersona() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 30),
        width: double.infinity,
        child: const Column(
          children: [
            Icon(
              Icons.person_pin,
              color: Color(0xFFFFC700),
              size: 100,
            ),
            SizedBox(height: 20),
            Text(
              'Pach_OS',
              style: TextStyle(
                fontSize: 54,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 0),
            Text(
              'Bienvenido al aplicativo movil Pach-OS.',
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 0),
            Text(
              'Por favor ingrese su correo y contraseña',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container CajaDeColor(Size size) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.white,
        Colors.white,
      ])),
      width: double.infinity,
      height: size.height * 0.4,
      child: Stack(
        children: [
          Positioned(child: Burbuja(), top: 90, left: 30),
          Positioned(child: Burbuja(), top: -40, left: -30),
          Positioned(child: Burbuja(), top: -50, right: -20),
          Positioned(child: Burbuja(), bottom: -50, left: -10),
          Positioned(child: Burbuja(), bottom: 120, right: -20)
        ],
      ),
    );
  }

  Container Burbuja() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: const Color.fromRGBO(255, 255, 255, 0.05)),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: LoginScreen(),
    ),
  );
}
