import 'package:flutter/material.dart';

import '../../../feature/common/widget/button/bottom_back_button.dart';
import '../../../navigation/wallet_routes.dart';
import '../../../theme/light_wallet_theme.dart';

class OrganizationCardActiviteiten extends StatelessWidget {
  const OrganizationCardActiviteiten({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ListView(
                  children: [
                    _DateHeader(date: 'Februari, 2025'),
                    _EventItem(
                      imageUrl: 'https://www.meegeldersepoort.nl/wp-content/uploads/2018/02/log-belastingdienst.jpg',
                      name: 'Belastingdienst',
                      eventType: 'Inloggen',
                      time: '12:07 door Siddhart Ghogli',
                    ),
                    _EventItem(
                      imageUrl: 'https://www.meegeldersepoort.nl/wp-content/uploads/2018/02/log-belastingdienst.jpg',
                      name: 'Belastingdienst',
                      eventType: 'Omzetbelasting',
                      time: '14:30 door Siffhart Ghogli',
                    ),
                    _DateHeader(date: 'Maart, 2025'),
                    _EventItem(
                      imageUrl: 'https://www.destartversneller.nl/wp-content/uploads/2019/01/kvk-logo.jpg',
                      name: 'KVK Website',
                      eventType: 'Inloggen',
                      time: '10:15 door Siffhart Ghogli',
                    ),
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

class _DateHeader extends StatelessWidget {
  final String date;

  const _DateHeader({required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.shade300),
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Text(
        date,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: LightWalletTheme.primaryColorDark,
        ),
      ),
    );
  }
}

class _EventItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String eventType;
  final String time;

  const _EventItem({
    required this.imageUrl,
    required this.name,
    required this.eventType,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.grey.shade300,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade300,
                    child: Icon(
                      Icons.error_outline,
                      color: Colors.grey.shade600,
                      size: 24,
                    ),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: Colors.grey.shade300,
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.grey.shade600),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: LightWalletTheme.primaryColorDark,
                  ),
                ),
                Text(
                  eventType,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: LightWalletTheme.primaryColorDark,
            size: 28.0, // Increased size for better visibility
          ),
        ],
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
          onPressed: () => Navigator.restorablePushNamed(
            context,
            WalletRoutes.organizationCardOptionsRoute,
          ),
          color: LightWalletTheme.primary,
          icon: Icon(Icons.arrow_back_rounded, size: 24.0),
        ),
        const Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Text(
            'Activiteiten',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: LightWalletTheme.primaryColorDark,
              fontSize: 24,
            ),
          ),
        ),
        const Text(
            'Op deze pagina vind je de activiteiten van deze kaart.',
            style: TextStyle(
              color: LightWalletTheme.primaryColorDark,
              fontSize: 16,
            ))
      ],
    ),
  );
} 