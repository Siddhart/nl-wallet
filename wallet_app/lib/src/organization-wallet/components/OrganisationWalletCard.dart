import 'package:flutter/material.dart';
import '../../navigation/wallet_routes.dart';
import '../models/OrganizationWalletCardObj.dart';

class OrganisationWalletCard extends StatelessWidget {
  final OrganizationWalletCardObj card;
  const OrganisationWalletCard({Key? key, required this.card})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: card.clickable
          ? () => Navigator.pushNamed(
                context,
                WalletRoutes.organizationCardOptionsRoute,
                arguments: {
                  'organizationId': card.organization,
                  'card': card
                }
              )
          : null,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          image: DecorationImage(
            image: AssetImage(card.backgroundImage),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Container(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: 150),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            card.name,
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: card.darkMode
                                    ? Color(0xFF152A62)
                                    : Colors.white),
                          ),
                          Text(
                            card.description,
                            style: TextStyle(
                                fontSize: 16,
                                color: card.darkMode
                                    ? Color(0xFF152A62)
                                    : Colors.white),
                          ),
                        ],
                      ),
                      if (card.clickable)
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Row(
                            children: [
                              Text(
                                'Bekijk',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: card.darkMode
                                      ? Color(0xFF152A62)
                                      : Colors.white,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Icon(Icons.arrow_forward_rounded,
                                    size: 24,
                                    color: card.darkMode
                                        ? Color(0xFF152A62)
                                        : Colors.white),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Image.asset(card.icon, fit: BoxFit.fill),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
