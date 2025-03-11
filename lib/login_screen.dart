import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart'; // Animaciones opcionales
import 'package:rive/rive.dart'; // Fondo animado opcional
import 'database_helper.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DatabaseHelper dbHelper = DatabaseHelper();
  bool _isLoading = false;

  void _login() async {
    setState(() => _isLoading = true);

    String username = _usernameController.text;
    String password = _passwordController.text;

    var user = await dbHelper.getUser(username, password);
    setState(() => _isLoading = false);

    if (user != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("¡Bienvenido, $username!")));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Credenciales incorrectas")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo animado con Rive
          Positioned.fill(child: RiveAnimation.asset("assets/background.riv")),
          Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Iniciar Sesión",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ).animate().fade(duration: 500.ms), // Animación opcional
                  SizedBox(height: 20),
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(labelText: "Usuario"),
                  ).animate().slideX(delay: 300.ms), // Animación opcional
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: "Contraseña"),
                    obscureText: true,
                  ).animate().slideX(delay: 400.ms), // Animación opcional
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    child:
                        _isLoading
                            ? CircularProgressIndicator()
                            : Text("Ingresar"),
                  ).animate().scale(delay: 500.ms), // Animación opcional
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
