import 'package:flutter/material.dart';

import '../../../../feature/common/widget/button/bottom_back_button.dart';
import '../../../../navigation/wallet_routes.dart';
import '../../../../theme/light_wallet_theme.dart';
import '../../../data/MyOrganizationWallets.dart';

class OrganizationWalletRolesScreen extends StatelessWidget {
  final String id;
  const OrganizationWalletRolesScreen({Key? key, required this.id})
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
            Expanded(child: _buildTeamRoles(context, walletData)),
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
            WalletRoutes.organizationWalletSettingsRoute,
            arguments: {'id': walletData["id"]},
          ),
          color: LightWalletTheme.primary,
          icon: Icon(Icons.arrow_back_rounded, size: 24.0),
        ),
        const Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Text(
            'Team',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: LightWalletTheme.primaryColorDark,
              fontSize: 24,
            ),
          ),
        ),
        const Text(
            'Op deze pagina vind je de verschillende rollen binnen uw organisatie wallet.',
            style: TextStyle(
              color: LightWalletTheme.primaryColorDark,
              fontSize: 16,
            ))
      ],
    ),
  );
}

Widget _buildTeamRoles(BuildContext context, Map<String, dynamic> walletData) {
  List<RoleObj> roles = [
    RoleObj(
      people: [PersonObj(firstName: 'Siddhart', lastName: 'Ghogli')],
      role: 'Eigenaar',
      id: '1',
    ),
    RoleObj(
      people: [PersonObj(firstName: 'John', lastName: 'Doe')],
      role: 'Developer',
      id: '2',
    ),
  ];

  return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 26),
      child: SingleChildScrollView(
        child: Column(
          spacing: 16,
          children: roles
              .map((role) => Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0x15579836)),
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xFFFCFCFC),
                    ),
                    child: TextButton(
                      onPressed: () => Navigator.restorablePushNamed(
                        context,
                        WalletRoutes.organizationWalletRolesPeopleRoute,
                        arguments: {'id': role.id},
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${role.people.length} ${role.people.length > 1 ? 'personen' : 'persoon'}",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: LightWalletTheme
                                      .colorScheme.onSurfaceVariant),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    role.role, // Assuming 'role' is the correct field to display here
                                    style: const TextStyle(
                                        fontSize: 21,
                                        color:
                                            LightWalletTheme.primaryColorDark,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_rounded,
                                    size: 24,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ));
}

class RoleObj {
  List<PersonObj> people;
  String role;
  String id;

  RoleObj({required this.people, required this.role, required this.id});
}

class PersonObj {
  String firstName;
  String lastName;

  PersonObj({required this.firstName, required this.lastName});
}
