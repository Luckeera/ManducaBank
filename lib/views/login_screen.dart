import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ManducaBank - Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navegação para a tela principal
            Navigator.pushReplacementNamed(context, '/principal');
          },
          child: const Text('Entrar'),
        ),
      ),
    );
  }
}
