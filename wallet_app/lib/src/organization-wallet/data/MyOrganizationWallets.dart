import 'dart:math';

import 'package:http/http.dart' as http;
import 'dart:convert';

class MyOrganizationWallets {
  static List<Map<String, dynamic>> getOrganizationWallets() {
    return [
      {
        'id': '1',
        'role': 'Eigenaar',
        'company_name': 'WebSloth',
        'email': 'siddhartssg@gmail.com',
        'password': 'Test123!',
        'endpoint': "https://wallet.businesswallet.eu",
        'wallet_id': "0458d438-e62c-4dcf-9073-6e2b213196c7",
      },
      {
        'id': '2',
        'role': 'Developer',
        'company_name': 'KVK',
        'email': 'siddhartssg@gmail.com',
        'password': 'Test123!',
        'endpoint': "https://wallet.businesswallet.eu",
        'wallet_id': "0458d438-e62c-4dcf-9073-6e2b213196c7",
      }
    ];
  }

  static Future<String> _authenticate(
      String endpoint, String email, String password) async {
    final response = await http.post(
        Uri.parse('$endpoint/wallet-api/auth/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json
            .encode({'email': email, 'password': password, 'type': 'email'}));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['token'];
    } else {
      throw Exception(response.body);
    }
  }

  static Future<List<dynamic>> getCredentials(String walletId) async {
    final wallet =
        getOrganizationWallets().firstWhere((w) => w['wallet_id'] == walletId);

    final token = await _authenticate(wallet['endpoint'],
        wallet['email'], wallet['password']);

    final url = wallet['endpoint'] + '/wallet-api/wallet/$walletId/credentials?showDeleted=false&showPending=false';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    // print(response.body);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load credentials');
    }
  }
}
