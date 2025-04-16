import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../organization_wallet_store.dart';

const _kOrganizationCredentialsKey = 'organization_credentials';

class OrganizationWalletStoreImpl extends OrganizationWalletStore {
  final PreferenceProvider _preferences;

  OrganizationWalletStoreImpl(this._preferences);

  @override
  Future<void> saveCredentials(OrganizationCredentials credentials) async {
    final prefs = await _preferences.call();
    final List<OrganizationCredentials> existingCredentials = await getAllCredentials();
    
    // Check if organization already exists
    final index = existingCredentials.indexWhere((c) => c.organizationName == credentials.organizationName);
    if (index != -1) {
      throw Exception('Organization ${credentials.organizationName} already exists');
    }

    existingCredentials.add(credentials);
    await _saveCredentialsList(prefs, existingCredentials);
  }

  @override
  Future<List<OrganizationCredentials>> getAllCredentials() async {
    final prefs = await _preferences.call();
    final String? jsonString = prefs.getString(_kOrganizationCredentialsKey);
    
    if (jsonString == null) {
      return [];
    }

    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => OrganizationCredentials(
      email: json['email'],
      password: json['password'],
      organizationName: json['organizationName'],
    )).toList();
  }

  @override
  Future<void> deleteCredentials(String organizationName) async {
    final prefs = await _preferences.call();
    final List<OrganizationCredentials> existingCredentials = await getAllCredentials();
    
    final updatedCredentials = existingCredentials.where(
      (c) => c.organizationName != organizationName
    ).toList();

    await _saveCredentialsList(prefs, updatedCredentials);
  }

  @override
  Future<void> updateCredentials(OrganizationCredentials credentials) async {
    final prefs = await _preferences.call();
    final List<OrganizationCredentials> existingCredentials = await getAllCredentials();
    
    final index = existingCredentials.indexWhere((c) => c.organizationName == credentials.organizationName);
    if (index == -1) {
      throw Exception('Organization ${credentials.organizationName} not found');
    }

    existingCredentials[index] = credentials;
    await _saveCredentialsList(prefs, existingCredentials);
  }

  Future<void> _saveCredentialsList(SharedPreferences prefs, List<OrganizationCredentials> credentials) async {
    final jsonList = credentials.map((c) => {
      'email': c.email,
      'password': c.password,
      'organizationName': c.organizationName,
    }).toList();
    
    await prefs.setString(_kOrganizationCredentialsKey, json.encode(jsonList));
  }
}

typedef PreferenceProvider = Future<SharedPreferences> Function(); 