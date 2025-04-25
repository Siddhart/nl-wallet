// This file is no longer used as the wallet selection UI has been moved to verify_choose_wallet.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../feature/common/screen/confirm_with_pin_screen.dart';
import '../../models/qr_code_data.dart';
import 'response/verify_success.dart';
import '../../../data/repository/card/wallet_card_repository.dart';
import 'verify_choose_wallet.dart';

class VerifyOverview extends StatelessWidget {
  final QrCodeData qrCodeData;
  const VerifyOverview({super.key, required this.qrCodeData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              // TODO: Implement help functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'Wil je gegevens delen met ${qrCodeData.pn}?',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E365B),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Bedenk altijd of delen verstandig is.',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF1E365B),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: const Divider(height: 1, color: Color(0xFFE0E0E0)),
            ),
            _SectionCard(
              icon: Icons.wallet,
              title: 'Wallet',
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Je staat op het punt gegevens van Persoonlijke Wallet te delen.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF1E365B),
                    ),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VerifyChooseWallet(qrCodeData: qrCodeData),
                        ),
                      );
                    },
                    icon: const Icon(Icons.swap_horiz),
                    label: const Text('Kies een andere wallet'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      foregroundColor: const Color(0xFF0043CE),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: const Divider(height: 1, color: Color(0xFFE0E0E0)),
            ),
            _SectionCard(
              icon: Icons.info_outline,
              title: 'Reden',
              content: Text(
                qrCodeData.r,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF1E365B),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: const Divider(height: 1, color: Color(0xFFE0E0E0)),
            ),
            _SectionCard(
              icon: Icons.article_outlined,
              title: 'Gegevens',
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  ...qrCodeData.ra.expand((block) => [
                    SizedBox(
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F7FA),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  block.n,
                                  style: const TextStyle(
                                    color: Color(0xFF152A62),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ...block.a.map((attr) => Text(
                                  attr,
                                  style: const TextStyle(
                                    color: Color(0xFF152A62),
                                    fontSize: 16,
                                  ),
                                )),
                              ],
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.network(
                                  block.i,
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 40,
                                      height: 40,
                                      color: Colors.grey[200],
                                      child: const Icon(Icons.image_not_supported, size: 20),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ]),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: const Divider(height: 1, color: Color(0xFFE0E0E0)),
            ),
            _SectionCard(
              icon: Icons.handshake_outlined,
              title: 'Afspraken',
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${qrCodeData.pn} zal je gegevens 12 maanden bewaren en niet delen met andere partijen.',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF1E365B),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton.icon(
                    onPressed: () {
                      // TODO: Implement terms view
                    },
                    icon: const Text('Lees de voorwaarden'),
                    label: const Icon(Icons.arrow_forward),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      },
                      icon: const Icon(Icons.block),
                      label: const Text('Stoppen'),
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
                        ConfirmWithPinScreen.show(
                          context,
                          (String? returnUrl) async {
                            try {
                              final repository =
                                  context.read<WalletCardRepository>();
                              final cards = await repository.readAll();
                              final selectedCard = cards.first;

                              final response = await http.post(
                                Uri.parse(qrCodeData.ep),
                                headers: {
                                  'Content-Type': 'application/json',
                                  'Accept': 'application/json',
                                },
                                body: json.encode(selectedCard),
                              );

                              if (response.statusCode == 200) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const VerifySuccess(),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('Error: ${response.statusCode}'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Error: $e'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                        );
                      },
                      icon:
                          const Icon(Icons.arrow_forward, color: Colors.white),
                      label: const Text('Delen',
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
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget content;

  const _SectionCard({
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
          child: Row(
            children: [
              Icon(icon, color: const Color(0xFF1E365B)),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E365B),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: content,
        ),
      ],
    );
  }
}
