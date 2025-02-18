import 'package:flutter/material.dart';

import '../../../../feature/common/widget/button/bottom_back_button.dart';
import '../../../../navigation/wallet_routes.dart';
import '../../../../theme/light_wallet_theme.dart';
import '../../../data/MyOrganizationWallets.dart';
import 'organization_wallet_roles_screen.dart';

class OrganizationWalletRolesPeopleScreen extends StatelessWidget {
  final String id;

  const OrganizationWalletRolesPeopleScreen({Key? key, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final walletData = MyOrganizationWallets.wallets
        .firstWhere((wallet) => wallet['id'] == id);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context, walletData),
            Expanded(child: _buildTeamRoles(context)),
            BottomBackButton()
          ],
        ),
      ),
    );
  }
}

Widget _buildTopBar(BuildContext context, Map<String, dynamic> walletData) {
  return Container(
    padding: EdgeInsets.only(left: 16, right: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          padding: EdgeInsets.only(top: 10, right: 24),
          onPressed: () => Navigator.restorablePushNamed(
            context,
            WalletRoutes.organizationWalletRolesRoute,
            arguments: {'id': walletData["id"]},
          ),
          color: LightWalletTheme.primary,
          icon: Icon(Icons.arrow_back_rounded, size: 24.0),
        ),
        const Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Text(
            'Eigenaar',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: LightWalletTheme.primaryColorDark,
              fontSize: 24,
            ),
          ),
        ),
        RichText(
          text: const TextSpan(
            style: TextStyle(
              color: LightWalletTheme.primaryColorDark,
              fontSize: 16,
              height: 1.25
            ),
            children: <TextSpan>[
              TextSpan(text: 'Op deze pagina vind je alle personen met de rol '),
              TextSpan(text: 'Eigenaar.', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildTeamRoles(BuildContext context) {
  List<PersonObj> people = [
    PersonObj(firstName: 'Siddhart', lastName: 'Ghogli')
  ];

  return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 26),
      child: SingleChildScrollView(
        child: Column(
          spacing: 16,
          children: people
              .map((person) => Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0x15579836)),
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xFFFCFCFC),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  (person.firstName + " " + person.lastName), // Assuming 'role' is the correct field to display here
                                  style: const TextStyle(
                                      fontSize: 21,
                                      color: LightWalletTheme.primaryColorDark,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ))
              .toList(),
        ),
      ));
}

class RoleObj {
  int people;
  String role;
  String id;

  RoleObj({required this.people, required this.role, required this.id});
}
