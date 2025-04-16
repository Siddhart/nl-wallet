import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../navigation/wallet_routes.dart';
import '../../theme/light_wallet_theme.dart';
import '../../wallet_assets.dart';
import '../components/OrganisationWalletCard.dart';
import '../data/MyOrganizationWallets.dart';
import '../models/OrganizationWalletCardObj.dart';

class OrganizationWalletScreen extends StatefulWidget {
  final String id;
  OrganizationWalletScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<OrganizationWalletScreen> createState() => _OrganizationWalletScreenState();
}

class _OrganizationWalletScreenState extends State<OrganizationWalletScreen> {
  Map<String, dynamic>? credentials;

  @override
  void initState() {
    super.initState();
    _loadCredentials();
  }

  Future<void> _loadCredentials() async {
    try {
      final walletData = MyOrganizationWallets.wallets
          .firstWhere((wallet) => wallet['id'] == widget.id);
      final data = await MyOrganizationWallets.getCredentials(walletData['wallet_id']);
      setState(() {
        credentials = data;
      });
    } catch (e) {
      print('Error loading credentials: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final walletData = MyOrganizationWallets.wallets
        .firstWhere((wallet) => wallet['id'] == widget.id);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context, walletData['company_name']),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildQrLogo(context),
                    _buildActivities(context),
                    _buildCards(context, [
                      OrganizationWalletCardObj(
                        id: '1',
                        name: 'KVK Uitreksel',
                        description: 'WebSloth',
                        darkMode: false,
                        backgroundImage: 'assets/non-free/images/bg_kvk.png',
                        icon: 'assets/non-free/logos/kvk.png',
                        clickable: true,
                        attributes: [
                          Attribute(name: 'Attribute 1', value: 'Value 1'),
                          Attribute(name: 'Attribute 2', value: 'Value 2'),
                        ],
                      ),
                      OrganizationWalletCardObj(
                        id: '1',
                        name: 'Sligro Klantenkaart',
                        description: 'WebSloth',
                        darkMode: true,
                        backgroundImage:
                            'assets/non-free/images/bg_default.png',
                        icon: 'assets/non-free/logos/sligro.png',
                        clickable: true,
                        attributes: [
                          Attribute(name: 'Attribute 1', value: 'Value 1'),
                          Attribute(name: 'Attribute 2', value: 'Value 2'),
                        ],
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, String walletName) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => Navigator.pushNamed(
                  context, WalletRoutes.organizationsOverviewRoute),
              icon: const Icon(
                Icons.arrow_back_rounded,
                size: 24,
                color: LightWalletTheme.primary,
              ),
            ),
            Text(
              walletName.toString(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            spacing: 16,
            children: [
              IconButton(
                onPressed: () =>
                    Navigator.pushNamed(context, WalletRoutes.qrRoute),
                icon: const Icon(
                  Icons.qr_code_rounded,
                  size: 24,
                  color: LightWalletTheme.primary,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.restorablePushNamed(
                  context,
                  WalletRoutes.organizationWalletSettingsRoute,
                  arguments: {'id': widget.id},
                ),
                icon: const Icon(
                  Icons.settings_outlined,
                  size: 24,
                  color: LightWalletTheme.primary,
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }

  Widget _buildQrLogo(BuildContext context) {
    onTapQr() => Navigator.pushNamed(context, WalletRoutes.qrRoute);
    return Semantics(
      button: true,
      excludeSemantics: true,
      child: SizedBox(
        height: 240,
        child: GestureDetector(
          onTap: onTapQr,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(WalletAssets.svg_qr_button),
              TextButton(
                onPressed: onTapQr,
                child: const Text(
                  'Scan QR-code',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivities(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("go to activities");
      },
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: Colors.white,
            border: Border.all(
              color: Color(0xFFE8EAEF),
              width: 1.0,
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                Text(
                  'Activiteiten afgelopen week',
                  style: TextStyle(
                      fontSize: 12, color: LightWalletTheme.primaryColorDark),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                        child: Text(
                      'Je hebt 2 kaarten toegevoegd, ingelogd bij Belastingdienst en gedeeld met Sligro.',
                      style: TextStyle(fontSize: 16),
                    )),
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        size: 24,
                        color: LightWalletTheme.primary,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCards(
      BuildContext context, List<OrganizationWalletCardObj> cards) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 16,
        children:
            cards.map((card) => OrganisationWalletCard(card: card)).toList(),
      ),
    );
  }
}
