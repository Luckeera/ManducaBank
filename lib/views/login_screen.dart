import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService authService = AuthService();

  // 🛠️ ADICIONADO: Controladores para capturar o texto dos inputs
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  @override
  void dispose() {
    // Limpa os controladores da memória quando a tela for destruída
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
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

                    // 🛠️ AJUSTADO: Passando o controller do Email
                    CustomInput(
                      hint: 'Email',
                      icon: Icons.email_outlined,
                      controller: emailController,
                    ),
                    const SizedBox(height: 20),

                    // 🛠️ AJUSTADO: Passando o controller da Senha
                    CustomInput(
                      hint: 'Senha',
                      icon: Icons.lock_outline,
                      obscureText: true,
                      controller: senhaController,
                    ),
                    const SizedBox(height: 30),

                    // 🛠️ AJUSTADO: Botão Entrar com a validação de campos vazios
                    // 🛠️ AJUSTADO: Botão Entrar com validações robustas de e-mail e senha
                    CustomButton(
                      text: 'Entrar',
                      onPressed: () {
                        final email = emailController.text.trim();
                        final senha = senhaController.text.trim();

                        // Expressão regular básica para validar formato de e-mail
                        final emailRegex =
                            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

                        // 1. Validação de campos vazios
                        if (email.isEmpty || senha.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Por favor, preencha todos os campos!'),
                              backgroundColor: Colors.redAccent,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                        // 2. Validação do formato do e-mail
                        else if (!emailRegex.hasMatch(email)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Por favor, insira um e-mail válido (ex: nome@email.com)!'),
                              backgroundColor: Colors.orangeAccent,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                        // 3. Validação do tamanho da senha (mínimo e máximo de 5 caracteres)
                        else if (senha.length != 5) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'A senha deve ter exatamente 5 caracteres!'),
                              backgroundColor: Colors.orangeAccent,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                        // Se passar em todas as regras, faz o login!
                        // Se passar em todas as regras, faz o login!
                        else {
                          // 🛠️ Truque: Pega o que está antes do '@' (ex: 'eden.silva@email.com' vira 'eden.silva')
                          String nomeExtraido = email.split('@').first;

                          // Deixa a primeira letra maiúscula (ex: 'eden' vira 'Eden')
                          if (nomeExtraido.isNotEmpty) {
                            nomeExtraido = nomeExtraido[0].toUpperCase() +
                                nomeExtraido.substring(1);
                          }

                          Navigator.pushReplacementNamed(
                            context,
                            '/principal',
                            arguments:
                                nomeExtraido, // 👈 ADICIONADO: Envia o nome para a próxima tela
                          );
                        }
                      },
                    ),

                    const SizedBox(
                        height: 12), // Espaçamento básico entre botões

                    ElevatedButton.icon(
                      onPressed: () async {
                        bool autenticado = await authService.autenticar();

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
                              content:
                                  Text('Biometria indisponível ou recusada'),
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.fingerprint),
                      label: const Text('Entrar com biometria'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                      ),
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
