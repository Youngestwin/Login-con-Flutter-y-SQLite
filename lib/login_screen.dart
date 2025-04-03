/*
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
*/

/*
// login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart'; // Opcional
//import 'package:rive/rive.dart'; // Opcional
import 'database_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _dbHelper = DatabaseHelper();

  Future<void> _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    final user = await _dbHelper.getUser(username, password);

    if (user != null) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Login exitoso!')));
        // Aquí puedes navegar a otra pantalla
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Credenciales inválidas')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo animado con Rive (opcional)
          // const RiveAnimation.asset('assets/background.riv'),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Usuario',
                        border: OutlineInputBorder(),
                      ),
                    )
                    .animate() // Animación opcional
                    .fadeIn(duration: 600.ms)
                    .slideY(begin: 0.2, end: 0),

                const SizedBox(height: 16),

                TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Contraseña',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    )
                    .animate() // Animación opcional
                    .fadeIn(duration: 600.ms)
                    .slideY(begin: 0.2, end: 0),

                const SizedBox(height: 24),

                ElevatedButton(
                      onPressed: _login,
                      child: const Text('Iniciar Sesión'),
                    )
                    .animate() // Animación opcional
                    .fadeIn(duration: 800.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
*/

// login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart'; // Opcional
//import 'package:rive/rive.dart'; // Opcional
import 'database_helper.dart';
import 'welcome_screen.dart'; // Importamos la nueva pantalla

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _dbHelper = DatabaseHelper();

  // login_screen.dart (fragmento)
  Future<void> _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    final user = await _dbHelper.getUser(username, password);

    if (user != null) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Login exitoso!')));
        Navigator.pushReplacementNamed(context, '/map'); // Navegar al mapa
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Credenciales inválidas')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo animado con Rive (opcional)
          // const RiveAnimation.asset('assets/background.riv'),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Usuario',
                    border: OutlineInputBorder(),
                  ),
                ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0),

                const SizedBox(height: 16),

                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0),

                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: _login,
                  child: const Text('Iniciar Sesión'),
                ).animate().fadeIn(duration: 800.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
