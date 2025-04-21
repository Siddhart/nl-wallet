import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wallet/environment.dart';
import 'package:wallet/src/wallet_assets.dart';
import 'package:wallet/src/navigation/wallet_routes.dart';

class VerifySuccess extends StatelessWidget {
  const VerifySuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              // TODO: Implement help functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Gelukt!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E365B),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Je gegevens zijn successvol gedeeld! Sluit dit scherm en ga verder op de website van BusinessWallet.eu',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF1E365B),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Lottie.asset(
                WalletAssets.lottie_intro_3,
                fit: BoxFit.contain,
                animate: !Environment.isTest,
                width: 240,
                height: 240,
              ),
            ),
            const Spacer(),
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        WalletRoutes.dashboardRoute,
                        (route) => false,
                      );
                    },
                    icon: const Icon(Icons.close),
                    label: const Text('Sluiten'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      backgroundColor: const Color(0xFF0043CE),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
