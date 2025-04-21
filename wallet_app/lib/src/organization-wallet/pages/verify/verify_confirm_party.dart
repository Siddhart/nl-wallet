import 'package:flutter/material.dart';
import 'verify_overview.dart';

class VerifyConfirmParty extends StatelessWidget {
  final String qrCodeUrl;
  const VerifyConfirmParty({super.key, required this.qrCodeUrl});

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/non-free/logos/business_wallet.png',
                width: 80,
                height: 80,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.only(left: 24, right: 24),
            child: Text(
              'Herken je BusinessWallet.eu',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E365B),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.only(left: 24, right: 24),
            child: Text(
              'Pas op voor fraude. Controleer het webadres op de website waar je QR-code hebt gescand.',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF1E365B),
              ),
            ),
          ),
          const SizedBox(height: 8),
         
          const SizedBox(height: 24),
          const Divider(height: 1, color: Color(0xFFE0E0E0)),
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 12),
            child: TextButton(
              onPressed: () {
                // TODO: Implement details view
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Bekijk details'),
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),
          ),
          const Divider(height: 1, color: Color(0xFFE0E0E0)),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Terug'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      side: const BorderSide(color: Color(0xFF0043CE)),
                      foregroundColor: const Color(0xFF0043CE),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VerifyOverview(qrCodeUrl: qrCodeUrl),
                        ),
                      );
                    },
                    icon: const Icon(Icons.arrow_forward, color: Colors.white),
                    label: const Text('Ja, verder',
                        style: TextStyle(color: Colors.white)),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      backgroundColor: const Color(0xFF0043CE),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
