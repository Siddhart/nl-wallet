// This file is no longer used as the wallet selection UI has been moved to verify_choose_wallet.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../feature/common/screen/confirm_with_pin_screen.dart';
import 'response/verify_success.dart';
import '../../../data/repository/card/wallet_card_repository.dart';

class VerifyOverview extends StatelessWidget {
  final String qrCodeUrl;
  const VerifyOverview({super.key, required this.qrCodeUrl});

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
            const Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                'Wil je gegevens delen met BusinessWallet.eu?',
                style: TextStyle(
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
                  Text(
                    'Je staat op het punt gegevens van Persoonlijke Wallet te delen.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF1E365B),
                    ),
                  ),
                  SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: () {
                      // TODO: Navigate to wallet selection
                    },
                    icon: Icon(Icons.swap_horiz),
                    label: Text('Kies een andere wallet'),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.all(16),
                      foregroundColor: Color(0xFF0043CE),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: const Divider(height: 1, color: Color(0xFFE0E0E0)),
            ),
            const _SectionCard(
              icon: Icons.info_outline,
              title: 'Reden',
              content: Text(
                'Inloggen',
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
              icon: Icons.description_outlined,
              title: 'Gevraagde gegevens',
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Alleen de volgende 3 gegevens worden gedeeld. Niets meer.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF1E365B),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.all(16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0xFFF1F5FF),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '3 uit Persoonsgegevens',
                              style: TextStyle(
                                color: Color(0xFF152A62),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                'assets/non-free/logos/rijksoverheid.png',
                                height: 24,
                                width: 24,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Voornaam\nAchternaam\nBSN Nummer',
                          style: TextStyle(
                            color: Color(0xFF152A62),
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextButton.icon(
                          onPressed: () {
                            // TODO: Implement details view
                          },
                          icon: Text(
                            'Bekijk',
                            style: TextStyle(color: Color(0xFF152A62)),
                          ),
                          label: Icon(Icons.arrow_forward, color: Color(0xFF152A62)),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ],
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
              icon: Icons.handshake_outlined,
              title: 'Afspraken',
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'BusinessWallet.eu zal je gegevens 12 maanden bewaren en niet delen met andere partijen.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF1E365B),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextButton.icon(
                    onPressed: () {
                      // TODO: Implement terms view
                    },
                    icon: Text('Lees de voorwaarden'),
                    label: Icon(Icons.arrow_forward),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(24),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.block),
                      label: Text('Stoppen'),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.all(16),
                        side: BorderSide(color: Color(0xFF0043CE)),
                        foregroundColor: Color(0xFF0043CE),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        ConfirmWithPinScreen.show(
                          context,
                          (String? returnUrl) async {
                            try {
                              final repository = context.read<WalletCardRepository>();
                              final cards = await repository.readAll();
                              final selectedCard = cards.first;

                              final response = await http.post(
                                Uri.parse(qrCodeUrl),
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
                                    content: Text('Error: ${response.statusCode}'),
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
                      icon: Icon(Icons.arrow_forward, color: Colors.white),
                      label: Text('Delen', style: TextStyle(color: Colors.white)),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.all(16),
                        backgroundColor: Color(0xFF0043CE),
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
              Icon(icon, color: Color(0xFF1E365B)),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
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
