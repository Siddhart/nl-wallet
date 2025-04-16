import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../feature/common/widget/button/bottom_back_button.dart';
import '../../../feature/common/widget/info_row.dart';
import '../../../navigation/wallet_routes.dart';
import '../../../theme/light_wallet_theme.dart';
import '../../components/OrganisationWalletCard.dart';
import '../../data/MyOrganizationWallets.dart';
import '../../models/OrganizationWalletCardObj.dart';
import '../settings/organization_wallet_settings_screen.dart';

class OrganizationCardOptions extends StatelessWidget {
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
                  children: [_buildCard(context), _buildOption(context)],
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
        ),
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

Widget _buildOption(BuildContext context) {
  List<OptionObj> options = [
    const OptionObj(
      icon: Icon(
        Icons.groups_2_outlined,
        size: 24,
      ),
      title: 'Gegevens in deze kaart',
      description: 'Bekijk de gegevens in deze kaart',
      route: WalletRoutes.organizationCardInfoRoute,
    ),
    const OptionObj(
      icon: Icon(
        Icons.history,
        size: 24,
      ),
      title: 'Activiteiten',
      description: 'Bekijk de activiteiten van deze kaart',
      route: WalletRoutes.organizationCardActiviteitenRoute,
    ),
  ];

  return Padding(
    padding: const EdgeInsets.only(top: 16),
    child: Container(
      child: Column(
        children: [
          const Divider(height: 1),
          ...options.map((option) => Column(
            children: [
              _buildOptionBar(context, option, {'id': '1'}),
              const Divider(height: 1),
            ],
          )).toList(),
        ],
      ),
    ),
  );
}

Widget _buildOptionBar(
    BuildContext context, OptionObj option, Map<String, dynamic> walletData) {
  if (option.route != null) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListTile(
        leading: option.icon,
        title: Text(
          option.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(option.description, style: const TextStyle(fontSize: 14)),
        trailing: const Icon(
          Icons.chevron_right,
          size: 24,
        ),
        onTap: () {
          Navigator.restorablePushNamed(context, option.route!,
              arguments: {'id': walletData["id"]});
        },
      ),
    );
  } else {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: ListTile(
        leading: option.icon,
        title: Text(
          option.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(option.description, style: const TextStyle(fontSize: 14)),
      ),
    );
  }
}

class OptionObj {
  final Icon icon;
  final String title;
  final String description;
  final String? route;

  const OptionObj({
    required this.icon,
    required this.title,
    required this.description,
    this.route,
  });
}