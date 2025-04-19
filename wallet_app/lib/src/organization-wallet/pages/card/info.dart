import 'package:flutter/material.dart';

import '../../../feature/common/widget/button/bottom_back_button.dart';
import '../../../navigation/wallet_routes.dart';
import '../../../theme/light_wallet_theme.dart';
import '../../models/OrganizationWalletCardObj.dart';

class OrganizationCardInfo extends StatelessWidget {
  const OrganizationCardInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Example attributes - in a real app these would come from the card object
    final List<Attribute> attributes = [
      Attribute(name: 'KvK nummer', value: '89595157'),
      Attribute(name: 'Naam van de organisatie', value: 'WebSloth'),
      Attribute(name: 'Handelsnamen', value: 'WebSloth'),
      Attribute(name: 'Type eigenaar', value: 'NatuurlijkPersoon'),
      Attribute(name: 'Rechtsvorm', value: 'Eenmanszaak'),
      Attribute(name: 'Adres van de organisatie', value: 'Abraham Bloemaertstraat 65, 2526LN, ‘s-Gravenhage'),
      Attribute(name: 'Emailadres van de organisatie', value: 'contact@siddhart.dev'),
      Attribute(name: 'SBI activiteit', value: '6201, Ontwikkelen, produceren en uitgeven van software'),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...attributes.map((attr) => Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            attr.name,
                            style: const TextStyle(
                              fontSize: 14,
                              color: LightWalletTheme.primaryColorDark,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            attr.value,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )).toList(),
                  ],
                ),
              ),
            ),
            BottomBackButton(),
          ],
        ),
      ),
    );
  }
}

Widget _buildTopBar(BuildContext context) {
  return Container(
    child: Row(
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_rounded,
            size: 24,
            color: LightWalletTheme.primary,
          ),
        ),
        const Text(
          'Gegevens in deze kaart',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: LightWalletTheme.primaryColorDark,
            fontSize: 24,
          ),
        ),
      ],
    ),
  );
}
