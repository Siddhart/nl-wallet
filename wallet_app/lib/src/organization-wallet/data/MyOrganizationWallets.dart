import 'dart:math';

import 'package:http/http.dart' as http;
import 'dart:convert';

class MyOrganizationWallets {
  static List<Map<String, dynamic>> wallets = [
    {
      'id': '1',
      'role': 'Eigenaar',
      'company_name': 'WebSloth',
      'email': 'siddhartssg@gmail.com',
      'password': 'Test123!',
      'endpoint': "http://87.106.57.244:7101",
      'wallet_id': "c83e080b-e5f0-4c06-9dda-85ec9ddbbc1f",
    }
  ];

  static Future<String> _authenticate(
      String endpoint, String email, String password) async {
    final response = await http.post(
      Uri.parse('$endpoint/wallet-api/auth/login'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode({
        'email': email,
        'password': password,
        'type': 'email'
      })   
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['token'];
    } else {
      throw Exception(response.body);
    }
  }

  static Future<Map<String, dynamic>> getCredentials(String walletId) async {
    final wallet = wallets.firstWhere((w) => w['wallet_id'] == walletId);

    print(wallet);

    final token = await _authenticate('http://87.106.57.244:7101', wallet['email'], wallet['password']);

    final url = 'http://87.106.57.244:7101/wallet-api/wallet/$walletId/credentials?showDeleted=false&showPending=false';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    
    print(response.body);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load credentials');
    }
  }
}
