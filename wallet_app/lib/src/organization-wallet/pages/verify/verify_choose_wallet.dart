import 'package:flutter/material.dart';
import '../../data/MyOrganizationWallets.dart';
import 'verify_confirm_party.dart';

class VerifyChooseWallet extends StatefulWidget {
  final String qrCodeUrl;
  const VerifyChooseWallet({super.key, required this.qrCodeUrl});

  @override
  State<VerifyChooseWallet> createState() => _VerifyChooseWalletState();
}

class _VerifyChooseWalletState extends State<VerifyChooseWallet> {
  String? selectedWalletId;
  List<Map<String, dynamic>> organizationWallets = [];

  @override
  void initState() {
    super.initState();
    organizationWallets = MyOrganizationWallets.getOrganizationWallets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              // TODO: Implement help functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Kies de wallet van waaruit de gegevens moeten worden verstuurd.',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E365B),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Selecteer je wallet. Gegevens van deze wallet worden verzonden naar de relying party.',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF1E365B),
              ),
            ),
            const SizedBox(height: 24),
            _WalletOption(
              icon: Icons.person_outline,
              title: 'Uw Persoonlijke Wallet',
              isSelected: selectedWalletId == 'personal',
              onTap: () {
                setState(() {
                  selectedWalletId = 'personal';
                });
              },
            ),
            const SizedBox(height: 16),
            ...organizationWallets.map((wallet) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _WalletOption(
                    icon: Icons.business,
                    title: wallet['company_name'],
                    isSelected: selectedWalletId == wallet['id'],
                    onTap: () {
                      setState(() {
                        selectedWalletId = wallet['id'];
                      });
                    },
                  ),
                )),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.block),
                    label: const Text('Stoppen'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      side: const BorderSide(color: Color(0xFF0043CE)),
                      foregroundColor: const Color(0xFF0043CE),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: selectedWalletId != null
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VerifyConfirmParty(qrCodeUrl: widget.qrCodeUrl),
                              ),
                            );
                          }
                        : null,
                    icon: Icon(
                      Icons.arrow_forward,
                      color: selectedWalletId != null ? Colors.white : const Color(0xFF0043CE),
                    ),
                    label: Text(
                      'Ga verder',
                      style: TextStyle(
                        color: selectedWalletId != null ? Colors.white : const Color(0xFF0043CE),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      backgroundColor: selectedWalletId != null ? const Color(0xFF0043CE) : Colors.white,
                      disabledBackgroundColor: Colors.white,
                      side: BorderSide(
                        color: const Color(0xFF0043CE),
                        width: selectedWalletId != null ? 0 : 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _WalletOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _WalletOption({
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF0043CE) : Colors.grey[300]!,
          ),
          color: isSelected ? const Color(0xFF0043CE) : Colors.white,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : const Color(0xFF0043CE),
              size: 24,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : const Color(0xFF1E365B),
              ),
            ),
            const Spacer(),
            if (isSelected)
              Icon(
                Icons.check,
                color: isSelected ? Colors.white : const Color(0xFF0043CE),
              ),
          ],
        ),
      ),
    );
  }
}
