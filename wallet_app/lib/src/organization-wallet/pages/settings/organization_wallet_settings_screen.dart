import 'package:flutter/material.dart';

import '../../../navigation/wallet_routes.dart';
import '../../../theme/light_wallet_theme.dart';
import '../../data/MyOrganizationWallets.dart';

class OrganizationWalletSettings extends StatelessWidget {
  final String id;
  OrganizationWalletSettings({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final walletData = MyOrganizationWallets.getOrganizationWallets()
        .firstWhere((wallet) => wallet['id'] == id);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context, walletData),
            Expanded(child: _buildOptions(context, walletData)),
            _buildBottomButton(context)
          ],
        ),
      ),
    );
  }
}

Widget _buildTopBar(BuildContext context, Map<String, dynamic> walletData) {
  return Padding(
    padding: const EdgeInsets.only(top: 8),
    child: Container(
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.restorablePushNamed(
              context,
              WalletRoutes.organizationWalletRoute,
              arguments: {'id': walletData["id"]},
            ),
            icon: const Icon(
              Icons.arrow_back_rounded,
              size: 24,
              color: LightWalletTheme.primary,
            ),
          ),
          const Text(
            'Organisatie Instellingen',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          )
        ],
      ),
    ),
  );
}

Widget _buildBottomButton(BuildContext context) {
  return Container(
    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        foregroundColor: MaterialStateProperty.all(Color(0xFFAB0065)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Color(0xFFAB0065), width: 1),
          ),
        ),
      ),
      onPressed: () {
        // Handle button press
      },
      child: const Row(
        spacing: 12,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.warning_amber, color: Color(0xFFAB0065)),
          Text('Wallet Verwijderen',
              style: TextStyle(color: Color(0xFFAB0065))),
        ],
      ),
    ),
  );
}

Widget _buildOptions(BuildContext context, Map<String, dynamic> walletData) {
  List<OptionObj> options = [
    const OptionObj(
      icon: const Icon(
        Icons.account_box_outlined,
        size: 24,
      ),
      title: 'Rol',
      description: 'Eigenaar',
    ),
    const OptionObj(
      icon: const Icon(
        Icons.groups_2_outlined,
        size: 24,
      ),
      title: 'Team',
      description: 'Bekijk de personen die toegang hebben tot deze wallet',
      route: WalletRoutes.organizationWalletRolesRoute,
    ),
    const OptionObj(
      icon: const Icon(
        Icons.history,
        size: 24,
      ),
      title: 'Activiteiten',
      description: 'Bekijk de activiteiten van deze wallet',
      route: WalletRoutes.aboutRoute,
    ),
  ];

  return Padding(
    padding: const EdgeInsets.only(top: 16),
    child: Container(
      child: Column(
        children: [
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              itemCount: options.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    _buildOptionBar(context, options[index], walletData),
                    if (index < options.length - 1) const Divider(height: 1),
                  ],
                );
              },
            ),
          ),
          const Divider(height: 1),
        ],
      ),
    ),
  );
}

Widget _buildOptionBar(
    BuildContext context, OptionObj option, Map<String, dynamic> walletData) {
  if (option.route != null) {
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
        subtitle:
            Text(option.description, style: const TextStyle(fontSize: 14)),
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
        subtitle:
            Text(option.description, style: const TextStyle(fontSize: 14)),
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
