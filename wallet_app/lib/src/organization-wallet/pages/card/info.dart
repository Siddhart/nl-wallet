import 'package:flutter/material.dart';

import '../../../feature/common/widget/button/bottom_back_button.dart';
import '../../../navigation/wallet_routes.dart';
import '../../../theme/light_wallet_theme.dart';
import '../../data/MyOrganizationWallets.dart';

class OrganizationCardInfo extends StatefulWidget {
  final String cardId;
  final String walletId;

  const OrganizationCardInfo({
    Key? key,
    required this.cardId,
    required this.walletId,
  }) : super(key: key);

  @override
  State<OrganizationCardInfo> createState() => _OrganizationCardInfoState();
}

class _OrganizationCardInfoState extends State<OrganizationCardInfo> {
  Map<String, dynamic>? cardData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCardData();
  }

  Future<void> _loadCardData() async {
    try {
      setState(() {
        isLoading = true;
      });
      final Map<String, dynamic> data = await MyOrganizationWallets.getCredentialData(
        widget.walletId,
        widget.cardId,
      );
      setState(() {
        cardData = data;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading card data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    print(cardData);
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
                    if (isLoading)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    else if (cardData == null || cardData!['parsedDocument'] == null)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text('No card data available'),
                        ),
                      )
                    else
                      _buildCardData(context),
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

  Widget _buildCardData(BuildContext context) {
    final credentialSubject = cardData!['parsedDocument']['credentialSubject'] as Map<String, dynamic>;
    final List<Widget> attributeWidgets = [];

    credentialSubject.forEach((key, value) {
      if (key != 'id') {
        attributeWidgets.add(
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _formatAttributeName(key),
                  style: const TextStyle(
                    fontSize: 14,
                    color: LightWalletTheme.primaryColorDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    });

    return Column(children: attributeWidgets);
  }

  String _formatAttributeName(String key) {
    // Only split when there's a lowercase followed by uppercase
    final words = key.replaceAllMapped(
      RegExp(r'([a-z])([A-Z])'),
      (match) => '${match.group(1)} ${match.group(2)}',
    );
    return words.trim().split(' ').map((word) => 
      word[0].toUpperCase() + word.substring(1).toLowerCase()
    ).join(' ');
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
