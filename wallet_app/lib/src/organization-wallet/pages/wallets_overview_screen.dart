import 'package:flutter/material.dart';

import '../../navigation/wallet_routes.dart';
import '../../theme/light_wallet_theme.dart';


class OrganizationsOverview extends StatelessWidget {
  const OrganizationsOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: _renderOrganizations(context),
            ),
            _buildBottomButton(context)
          ],
        ),
      ),
    );
  }
}

Widget _buildTopBar(BuildContext context) {
  return Container(
    padding: EdgeInsets.only(left: 16, right: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          padding: EdgeInsets.only(top: 10, right: 24),
          onPressed: () => Navigator.pushNamed(
            context,
            WalletRoutes.dashboardRoute,
          ),
          color: LightWalletTheme.primary,
          icon: Icon(Icons.arrow_back_rounded, size: 24.0),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Text(
            'Mijn Organisatie Wallets',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: LightWalletTheme.primaryColorDark,
              fontSize: 24,
            ),
          ),
        ),
        Text(
            'Op deze pagina beheer je al jouw organisatie wallets. Klik op een organisatie om toegang te krijgen of voeg eerst een nieuwe wallet toe.',
            style: TextStyle(
              color: LightWalletTheme.primaryColorDark,
              fontSize: 16,
            ))
      ],
    ),
  );
}

Widget _renderOrganizations(BuildContext context) {
  return Container(
    padding: const EdgeInsets.only(left: 16, right: 16, top: 26),
    child: SingleChildScrollView(
      child: Column(
        spacing: 16,
        children: [
          OrganizationObject(
            company: 'WebSloth',
            role: 'Eigenaar',
          ),
          OrganizationObject(
            company: 'Kamer van Koophandel',
            role: 'Developer',
          ),
        ],
      ),
    ),
  );
}

Widget _buildBottomButton(BuildContext context) {
  return Container(
    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
    child: ElevatedButton(
      onPressed: () {
        // Handle button press
      },
      child: Row(
        spacing: 12,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.arrow_forward_rounded, color: Colors.white),
          Text('Wallet Toevoegen'),
        ],
      ),
    ),
  );
}

class OrganizationObject extends StatelessWidget {
  final String company;
  final String role;

  const OrganizationObject(
      {Key? key, required this.company, required this.role})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0x15579836)),
        borderRadius: BorderRadius.circular(8),
        color: Color(0xFFFCFCFC),
      ),
      child: TextButton(
        onPressed: () => Navigator.pushNamed(
            context, WalletRoutes.organizationWalletRoute),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                this.role,
                style: TextStyle(
                    fontSize: 14,
                    color: LightWalletTheme.colorScheme.onSurfaceVariant),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      this.company,
                      style: const TextStyle(
                          fontSize: 21,
                          color: LightWalletTheme.primaryColorDark,
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
    );
  }
}
