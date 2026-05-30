import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatelessWidget {

  LoginScreen({super.key});

  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(

      duration:
        const Duration(milliseconds: 300),

      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF121212),
                Color(0xFF1E1E1E),
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    const Icon(
                      Icons.account_balance,
                      size: 90,
                      color: Color.fromARGB(255, 255, 62, 126),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'ManducaBank',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Seu banco digital moderno',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 50),
                    const CustomInput(
                      hint: 'Email',
                      icon: Icons.email_outlined,
                    ),
                    const SizedBox(height: 20),
                    const CustomInput(
                      hint: 'Senha',
                      icon: Icons.lock_outline,
                      obscureText: true,
                    ),
                    const SizedBox(height: 30),
                    CustomButton(
                      text: 'Entrar',
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          '/principal',
                        );
                      },
                    ),

                    ElevatedButton.icon(
                     onPressed: () async {
                        bool autenticado =
                          await authService.autenticar();

                       if (autenticado) {

                       ScaffoldMessenger.of(context).showSnackBar(
                         const SnackBar(
                           content: Text('Biometria autenticada!'),
                         ),
                       );

                       Navigator.pushReplacementNamed(
                         context,
                        '/principal',
                       );

                    } else {

                     ScaffoldMessenger.of(context).showSnackBar(
                       const SnackBar(
                         content: Text('Biometria indisponível'),
                      ),
                   );

                }
                      },
                       icon: const Icon(Icons.fingerprint),
                       label: const Text('Entrar com biometria'),
                    ),

                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Esqueceu sua senha?',
                        style: TextStyle(
                          color: Color.fromARGB(255, 252, 76, 135),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),  
    );
  }
}
