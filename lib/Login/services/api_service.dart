import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<void> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('https://localhost:7229/api/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
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
}
