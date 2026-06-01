import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final DatabaseHelper db = DatabaseHelper();

    return FutureBuilder<double>(
      future: db.getSaldo(),
      builder: (context, snapshot) {
        final double saldo = snapshot.data ?? 0.0;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 218, 54, 109),
                Color.fromARGB(255, 218, 54, 109),
              ],
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 218, 54, 109).withOpacity(0.4),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Saldo disponível',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'R\$ ${saldo.toStringAsFixed(2).replaceAll('.', ',')}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Conta',
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '000123-4',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.visibility,
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
