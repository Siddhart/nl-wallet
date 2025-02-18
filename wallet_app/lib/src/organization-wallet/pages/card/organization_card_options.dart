import 'package:flutter/material.dart';

import '../../../feature/common/widget/button/bottom_back_button.dart';
import '../../../navigation/wallet_routes.dart';
import '../../../theme/light_wallet_theme.dart';
import '../../components/OrganisationWalletCard.dart';
import '../../data/MyOrganizationWallets.dart';
import '../../models/OrganizationWalletCardObj.dart';

class OrganizationCardOptions extends StatelessWidget {
  // final String id;

  // const OrganizationCardOptions({Key? key, required this.id}) : super(key: key);
  const OrganizationCardOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [_buildCard(context)],
                ),
              ),
            ),
            BottomBackButton()
          ],
        ),
      ),
    );
  }
}

Widget _buildTopBar(BuildContext context) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => Navigator.pushNamed(
                context,
                WalletRoutes.organizationWalletRoute,
                arguments: {'id': 1},
              ),
              icon: const Icon(
                Icons.arrow_back_rounded,
                size: 24,
                color: LightWalletTheme.primary,
              ),
            ),
            const Text(
              'KVK Uitreksel',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: LightWalletTheme.primaryColorDark,
                fontSize: 24,
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            spacing: 16,
            children: [
              IconButton(
                onPressed: () => Navigator.restorablePushNamed(
                  context,
                  WalletRoutes.organizationWalletSettingsRoute,
                ),
                icon: const Icon(
                  Icons.help_outline_outlined,
                  size: 24,
                  color: LightWalletTheme.primary,
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget _buildCard(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
    child: OrganisationWalletCard(
      card: OrganizationWalletCardObj(
        id: '1',
        name: 'KVK Uitreksel',
        description: 'WebSloth',
        darkMode: false,
        backgroundImage: 'assets/non-free/images/bg_kvk.png',
        clickable: false,
        icon: 'assets/non-free/logos/kvk.png',
        attributes: [
          Attribute(name: 'Attribute 1', value: 'Value 1'),
          Attribute(name: 'Attribute 2', value: 'Value 2'),
        ],
      ),
    ),
  );
}
